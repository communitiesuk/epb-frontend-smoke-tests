# frozen_string_literal: true

require 'http'

# :nodoc:
module Worker
  class SlackNotification
    include Sidekiq::Worker

  end
end
