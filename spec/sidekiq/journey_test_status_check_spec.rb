# frozen_string_literal: true

describe JourneyTestStatusCheck do
  let(:helper) { described_class.new }

  context 'when there are no failures' do
    it 'returns the journey test status in a ruby object' do
      result = helper.get_failure_count('spec/fixtures/output_success.json')
      expect(result).to eq(0)
    end
  end

  context 'when there are failures' do
    it 'returns the journey test status in a ruby object' do
      result = helper.get_failure_count('spec/fixtures/output_failure.json')
      expect(result).to eq(11)
    end

    it 'returns only the errors' do
      result = helper.format_errors(JSON.load_file('spec/fixtures/output_failure.json'))
      expect(result.count).to eq(11)
    end

    it 'returns the errors for in the correct format' do
      errors =
        {
          full_description: 'Find a Domestic Assessor English when searching for an existing building by name shows assessor search results',
          message: 'Unable to find field "name" that is not disabled',
          rspec_file_path: './spec/journey/find_domestic_assesor_by_name_spec.rb[1:1:1]'
        }

      result = helper.format_errors(JSON.load_file('spec/fixtures/output_failure.json'))
      expect(result.first).to eq(errors)
    end

    # it 'post the errors to slack' do
    #   errors = helper.format_errors(JSON.load_file('spec/fixtures/output_failure.json'))
    #
    #   expect { helper.post_errors_to_slack(errors) }.not_to raise_error
    # end
  end
end
