# frozen_string_literal: true

require 'sidekiq'
require 'rake'

module Worker
  class RunTests
    include Sidekiq::Worker

    def perform
      rake_task('spec').invoke
      status_check = JourneyTestStatusCheck.new
      rspec_output = JSON.load_file('logs/output.json')
      if status_check.get_failure_count(rspec_output) >= 1
        status_check.format_and_send_errors(rspec_output)
      end
    end

    def rake_task(name)
      rake = Rake::Application.new
      Rake.application = rake
      rake.load_rakefile
      rake.tasks.find { |task| task.to_s == name }
    end
  end
end
