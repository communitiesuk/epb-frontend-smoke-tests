# frozen_string_literal: true

describe JourneyTestStatusCheck do
  let(:rspec_success) { JSON.load_file('spec/fixtures/output_success.json') }
  let(:rspec_failures) { JSON.load_file('spec/fixtures/output_failure.json') }
  let(:slack_agent) { SlackGateway.new }

  context 'when there are no failures' do
    it 'returns the journey test status in a ruby object' do
      my_subject = described_class.new(rspec_output: rspec_success, slack_gateway: slack_agent)
      result = my_subject.failure_count
      expect(result).to eq(0)
    end
  end

  context 'when there are failures' do
    let(:my_subject) { described_class.new(rspec_output: rspec_failures, slack_gateway: slack_agent) }

    before do
      WebMock.enable!
      allow(ENV).to receive(:[])
    end

    after { WebMock.disable! }

    it 'returns the journey test status in a ruby object' do
      result = my_subject.failure_count
      expect(result).to eq(11)
    end

    it 'returns only the errors' do
      result = my_subject.format_errors
      expect(result.count).to eq(11)
    end

    it 'returns the errors for in the correct format' do
      errors =
        {
          full_description: 'Find a Domestic Assessor English when searching for an existing building by name shows assessor search results',
          message: 'Unable to find field "name" that is not disabled',
          rspec_file_path: './spec/journey/find_domestic_assesor_by_name_spec.rb[1:1:1]'
        }

      result = my_subject.format_errors
      expect(result.first).to eq(errors)
    end

    it 'send the error test to the slack agent' do
      allow(slack_agent).to receive(:post)
      allow(ENV).to receive(:[]).with('EPB_TEAM_SLACK_URL').and_return('https://example.com/webhook')

      slack_request = WebMock.stub_request(:post, 'https://example.com/webhook')
                             .to_return(status: 200, headers: {})
      my_subject.format_and_send_errors
      expect(slack_agent).to have_received(:post).exactly(1)
    end

    it 'sends a Slack notification to this webhook if the URL is set' do
      allow(ENV).to receive(:[]).with('EPB_TEAM_SLACK_URL').and_return('https://example.com/webhook')

      slack_request = WebMock.stub_request(:post, 'https://example.com/webhook')
                             .to_return(status: 200, headers: {})

      my_subject.format_and_send_errors

      expect(slack_request).to have_been_made
    end

    it 'raise an error if EPB_TEAM_SLACK_URL is empty' do
      allow(ENV).to receive(:[]).with('EPB_TEAM_SLACK_URL').and_return(nil)

      stub_request(:post, 'https://example.com/webhook').to_return(status: 200, headers: {})

      expect do
        my_subject.format_and_send_errors
      end.to raise_error(StandardError, 'There is no Slack URL set')
    end

    context 'when ENV post over ride is set ' do


      it 'does not post to slack' do
        allow(ENV).to receive(:[]).with('POST_TO_SLACK').and_return('false')
        slack_request = WebMock.stub_request(:post, 'https://example.com/webhook')
                               .to_return(status: 200, headers: {})

        my_subject.format_and_send_errors
        expect(slack_request).not_to have_been_made
      end
    end
  end
end
