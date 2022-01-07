# frozen_string_literal: true

require 'http'

# :nodoc:
module Worker
  class SlackNotification
    include Sidekiq::Worker

    def perform(text, url = nil)
      @webhook_url = ENV['EPB_TEAM_SLACK_URL']

      if @webhook_url.present?
        message = url.present? ? hyperlink(text, url) : text
        post_to_slack message
      end
    end

    private

    def hyperlink(text, url)
      "<#{url}|#{text}>"
    end

    def post_to_slack(text)
      if ENV['STAGE'] == 'production'
        slack_message = text
        slack_channel = '#team-epb'
      else
        slack_message = "[#{ENV['STAGE']}] #{text}"
        slack_channel = '#team-epb-pre-production'
      end

      payload = { username: 'Energy Performance of Buildings', channel: slack_channel, text: slack_message,
                  mrkdwn: true }

      response = HTTP.post(@webhook_url, body: payload.to_json)

      raise SlackMessageError, "Slack error: #{response.body}" unless response.status.success?
    end

    class SlackMessageError < StandardError; end
  end
end
