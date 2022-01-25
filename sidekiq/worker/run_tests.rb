# frozen_string_literal: true

require 'sidekiq'
require 'rake'

module Worker
  class RunTests
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform
      system('rspec spec/journey/*_spec.rb --format json --out logs/output.json --format documentation')
      rspec_output = JSON.load_file('logs/output.json')
      status_check = JourneyTestStatusCheck.new(rspec_output: rspec_output, slack_gateway: SlackGateway.new)
      if status_check.failure_count >= 1
        status_check.format_and_send_errors
      else
        pp 'Smoke test passed'
      end
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
  end
end
