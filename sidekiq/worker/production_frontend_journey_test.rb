# frozen_string_literal: true

require 'sidekiq'

class ProductionFrontEndJourneyTest
  include Sidekiq::Worker

  def perform
    system('bundle exec rspec spec')
  end
end
