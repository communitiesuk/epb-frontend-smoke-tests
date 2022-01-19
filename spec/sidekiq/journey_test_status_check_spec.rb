# frozen_string_literal: true
require "webmock/rspec"

describe JourneyTestStatusCheck do
  let(:helper) { described_class.new }
  let(:rspec_success) { JSON.load_file('spec/fixtures/output_success.json') }
  let(:rspec_failures) { JSON.load_file('spec/fixtures/output_failure.json') }

  context 'when there are no failures' do
    it 'returns the journey test status in a ruby object' do
      result = helper.get_failure_count(rspec_success)
      expect(result).to eq(0)
    end
  end

  context 'when there are failures' do
    before do
      WebMock.enable!
      allow(ENV).to receive(:[])
    end

    after { WebMock.disable! }

    it 'returns the journey test status in a ruby object' do
      result = helper.get_failure_count(rspec_failures)
      expect(result).to eq(11)
    end

    it 'returns only the errors' do
      result = helper.format_errors(rspec_failures)
      expect(result.count).to eq(11)
    end

    it 'returns the errors for in the correct format' do
      errors =
        {
          full_description: 'Find a Domestic Assessor English when searching for an existing building by name shows assessor search results',
          message: 'Unable to find field "name" that is not disabled',
          rspec_file_path: './spec/journey/find_domestic_assesor_by_name_spec.rb[1:1:1]'
        }

      result = helper.format_errors(rspec_failures)
      expect(result.first).to eq(errors)
    end

    it 'sends a Slack notification to this webhook if the URL is set' do
      allow(ENV).to receive(:[]).with("EPB_TEAM_SLACK_URL").and_return("https://example.com/webhook")

      slack_request = WebMock.stub_request(:post, 'https://example.com/webhook')
                             .to_return(status: 200, headers: {})

      helper.format_and_send_errors(rspec_failures)

      expect(slack_request).to have_been_made
    end

    it 'raise an error if EPB_TEAM_SLACK_URL is empty' do
      allow(ENV).to receive(:[]).with("EPB_TEAM_SLACK_URL").and_return(nil)

      stub_request(:post, 'https://example.com/webhook').to_return(status: 200, headers: {})

      expect { helper.format_and_send_errors(rspec_failures) }.to raise_error(StandardError, 'There is no Slack URL set')
    end
  end
end
