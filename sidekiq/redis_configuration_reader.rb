# frozen_string_literal: true

# :nodoc:
class RedisConfigurationReader
  class ConfigurationError < StandardError; end

  def self.read_configuration_url(instance_name)
    vcap_services = JSON.parse(ENV['VCAP_SERVICES'], symbolize_names: true)

    if vcap_services[:redis].nil?
      raise ConfigurationError,
            'No Redis configuration found in VCAP_SERVICES'
    end

    vcap_services[:redis].each do |config|
      return config.dig(:credentials, :uri) if config[:instance_name] == instance_name
    end

    raise ConfigurationError,
          "#{instance_name} is not a valid redis instance"
  end
end
