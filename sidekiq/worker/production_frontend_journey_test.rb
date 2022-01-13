# frozen_string_literal: true

require 'sidekiq'

module Worker
class ProductionFrontEndSmokeTest
  include Sidekiq::Worker

  def perform
    pp "I'm running!"
    # system('bundle exec rspec spec')
  end
end
end
