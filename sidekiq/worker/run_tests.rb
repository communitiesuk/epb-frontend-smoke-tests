# frozen_string_literal: true

require 'sidekiq'
require 'rake'

module Worker
  class RunTests
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform
      rake_task('spec').invoke
      rspec_output = JSON.load_file('logs/output.json')
      status_check = JourneyTestStatusCheck.new(rspec_output)
      status_check.format_and_send_errors if status_check.failure_count >= 1
    end

    private
    def rake_task(name)
      rake = Rake::Application.new
      Rake.application = rake
      rake.load_rakefile
      rake.tasks.find { |task| task.to_s == name }
    end
  end
end
