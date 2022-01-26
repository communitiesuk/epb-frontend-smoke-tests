# frozen_string_literal: true

require 'capybara/rspec'
require 'http'
require 'selenium/webdriver'
require 'shared_context'
require 'zeitwerk'
require 'webmock/rspec'
require 'sidekiq/testing'

ENV['test_success'] = 'false'

class TestLoader
  def self.setup
    @loader = Zeitwerk::Loader.new
    @loader.push_dir("#{__dir__}/../sidekiq/")
    @loader.setup
  end

  def self.override(path)
    load path
  end
end

TestLoader.setup

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include Capybara::DSL
  config.include_context 'domains'

  config.before { WebMock.disable! }
end

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium_chrome_headless
end
