# frozen_string_literal: true

require 'sidekiq'
require 'rake'

module Worker
  class RunTests
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform
      FileUtils.rm_rf log_files
      passed = system('npm run test-with-delay')
      if passed
        pp 'Smoke test suite passed'
        return
      end
      cypress_errors = log_files.map { |file| JSON.load_file file }
      status_check = JourneyTestFailureProcessor.new(cypress_errors: cypress_errors, slack_gateway: SlackGateway.new)
      status_check.format_and_send_errors
    rescue StandardError => e
      send_error_to_slack e
    end

    private

    def rake_task(name)
      rake = Rake::Application.new
      Rake.application = rake
      rake.load_rakefile
      rake.tasks.find { |task| task.to_s == name }
    end

    def send_error_to_slack(error)
      gateway = SlackGateway.new
      error_text = ':fire: EPB FRONTEND SMOKE TESTS WORKER HAS FAILED: '
      error_text += "\n
                      Error: #{error.message}\n"

      gateway.post(error_text)
    end

    def log_files
      Dir.glob("#{__dir__}/../../cypress/logs/*.json")
    end
  end
end
