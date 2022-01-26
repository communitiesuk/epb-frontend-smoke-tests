# frozen_string_literal: true

require 'json'
require 'http'

class JourneyTestFailureProcessor
  def initialize(cypress_errors:, slack_gateway:)
    @slack_gateway = slack_gateway
    @cypress_errors = cypress_errors
  end

  def format_and_send_errors
    post_errors_to_slack(format_errors)
  end

  def format_errors
    @cypress_errors.map do |example|
      {
        full_description: example['testName'],
        message: example['testError'],
        test_file: example['specName'].split('%2F').slice(1)
      }
    end
  end

  def post_errors_to_slack(formatted_errors)
    error_text = ':fire: EPB FRONTEND SMOKE TEST FAILURE: '
    formatted_errors.each do |e|
      error_text += "\n
                      Test: #{e[:full_description]} has failed\n
                      with error: #{e[:message]}\n
                      in test file: #{e[:test_file]}\n"
    end

    @slack_gateway.post(error_text) if ENV['POST_TO_SLACK'].nil? || ENV['POST_TO_SLACK'] == 'true'
  end
end
