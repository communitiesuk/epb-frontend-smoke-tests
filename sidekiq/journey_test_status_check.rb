# frozen_string_literal: true

require 'json'
require 'http'

class JourneyTestStatusCheck


  def initialize(rspec_output)
    @rspec_output = rspec_output
  end


  def failure_count
    @rspec_output['summary']['failure_count']
  end

  def format_and_send_errors
    post_errors_to_slack(format_errors)
  end


  def format_errors
    errors = @rspec_output['examples'].select { |r| r['status'] == 'failed' }

    errors.map do |example|
      {
        full_description: example['full_description'],
        message: example['exception']['message'],
        rspec_file_path: example['id']
      }
    end
  end

  def post_errors_to_slack(formatted_errors)
    error_text = ':fire: EPB FRONTEND SMOKE TEST FAILURE: '
    formatted_errors.each do |e|
      error_text += "\n
                      Test: #{e[:full_description]} has failed\n
                      with error: #{e[:message]}\n
                      on line: #{e[:rspec_file_path]}\n"
    end

    webhook_url = ENV['EPB_TEAM_SLACK_URL']
    if webhook_url.nil?
      raise StandardError, 'There is no Slack URL set'
    else
      payload = { username: 'Energy Performance of Buildings', channel: 'team-epb', text: error_text,
                  mrkdwn: true }

      HTTP.post(webhook_url, body: payload.to_json)
    end
  end
end
