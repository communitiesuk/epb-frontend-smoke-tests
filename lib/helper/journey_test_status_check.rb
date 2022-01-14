require 'json'

module Helper
  class JourneyTestStatusCheck
    def get_failure_count(file_path)
      raw_json = JSON.load_file(file_path)
      raw_json['summary']['failure_count']
    end
  end
end