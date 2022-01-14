# frozen_string_literal: true

require 'sidekiq'

module Worker
  class RunTests
    include Sidekiq::Worker

    def perform
      pp "I'm running!"
      # system('bundle exec rspec spec')
    end
  end
end
