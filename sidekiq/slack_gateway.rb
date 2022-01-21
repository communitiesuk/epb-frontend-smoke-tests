# frozen_string_literal: true

class SlackGateway

  def post(error_text)
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
