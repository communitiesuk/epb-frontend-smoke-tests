# frozen_string_literal: true

require 'capybara/rspec'
require 'selenium/webdriver'
require 'shared_context'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include Capybara::DSL
  config.include_context 'domains'
end

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium_chrome_headless
end
