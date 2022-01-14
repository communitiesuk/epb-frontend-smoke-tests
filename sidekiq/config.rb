# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq-cron'
require 'zeitwerk'

class SidekiqLoader
  def self.setup
    loader = Zeitwerk::Loader.new
    loader.push_dir("#{__dir__}/../sidekiq")
    loader.setup
  end
end

SidekiqLoader.setup

environment = ENV["STAGE"] || "development"

unless %w[development test].include? environment
  redis_url = RedisConfigurationReader.read_configuration_url("dluhc-epb-redis-frontend-smoke-tests")
  Sidekiq.configure_server do |config|
    config.redis = { url: redis_url, network_timeout: 5 }
  end
end

schedule_file = './sidekiq/schedule.yml'

Sidekiq::Cron::Job.load_from_hash! YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?
