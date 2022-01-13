require 'sidekiq'

module Worker
  class Test
    include Sidekiq::Worker

    def perform
      pp "I'm running a test!"
      # system('bundle exec rspec spec')
    end
  end
end
