# frozen_string_literal: true

require 'json'

class JourneyTestStatusCheck
  def get_failure_count(file_path)
    raw_json = JSON.load_file(file_path)
    raw_json['summary']['failure_count']
  end

  def format_errors(results)
    errors = results['examples'].select { |r| r['status'] == 'failed' }

    errors.map do |example|
      {
        full_description: example['full_description'],
        message: example['exception']['message'],
        rspec_file_path: example['id']
      }
    end
  end

  def post_errors_to_slack(formatted_errors)
    error_hash = formatted_errors
    error_text = 'EPB FRONTEND SMOKE TEST FAILURE: '
    error_hash.each do |e|
      error_text += "\n Test: #{e[:full_description]} has failed\nwith error: #{e[:message]}\n on line: #{e[:rspec_file_path]}\n"
    end

    webhook_url = ''
    payload = { username: 'Energy Performance of Buildings', channel: 'team-epb', text: error_text,
                mrkdwn: true }

    HTTP.post(webhook_url, body: payload.to_json)
  end
end
