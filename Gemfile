# frozen_string_literal: true

ruby '~> 3.0.2'

source 'https://rubygems.org' do
  group :test do
    gem 'rspec', '~>3.10'
    gem 'rspec-sidekiq'
    gem 'webmock', '~> 3.14.0'
  end

  group :worker do
    gem 'sidekiq', '~> 6.3.1'
    gem 'sidekiq-cron', '~> 1.2.0'
  end

  gem 'capybara', '~> 3.36.0'
  gem 'http'
  gem 'json'
  gem 'rake', '~> 13.0', '>= 13.0.6'
  gem 'rubocop-rspec'
  gem 'selenium-webdriver', '~> 4.1.0'
  gem 'zeitwerk', '~> 2.4.1'
end
