# frozen_string_literal: true

require 'sidekiq'
require 'rake'

module Worker
  class RunTests
    include Sidekiq::Worker
    sidekiq_options retry: 1

    def perform


      rake_task('spec').invoke
      status_check = JourneyTestStatusCheck.new
      rspec_output = JSON.load_file('logs/output.json')
      status_check.format_and_send_errors(rspec_output) if status_check.get_failure_count(rspec_output) >= 1

    end

    def rake_task(name)
      rake = Rake::Application.new
      Rake.application = rake
      rake.load_rakefile
      rake.tasks.find { |task| task.to_s == name }
    end
  end
end
