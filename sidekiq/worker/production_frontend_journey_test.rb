# frozen_string_literal: true

require 'sidekiq'

class ProductionFrontEndJourneyTest
  include Sidekiq::Worker

  def perform
    pp "I'm running!"
    # system('bundle exec rspec spec')
  end
end
