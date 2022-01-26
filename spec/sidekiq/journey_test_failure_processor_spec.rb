# frozen_string_literal: true

describe JourneyTestFailureProcessor do
  let(:failures) { Dir.glob('spec/fixtures/cypress_errors/*.json').map { |file| JSON.load_file file } }
  let(:slack_agent) { SlackGateway.new }

  let(:my_subject) { described_class.new(cypress_errors: failures, slack_gateway: slack_agent) }

  before do
    WebMock.enable!
    allow(ENV).to receive(:[])
  end

  after { WebMock.disable! }

  it 'returns only the errors' do
    result = my_subject.format_errors
    expect(result.count).to eq(3)
  end

  it 'returns the errors for in the correct format' do
    errors =
      {
        full_description: 'Find a non-domestic assessor (English) when searching by name shows assessor search results',
        message: "Timed out retrying after 4000ms: Expected to find element: `input[name=name]`, but never found it.\n\nBecause this error occurred during a `before each` hook we are skipping the remaining tests in the current suite: `when searching by name`",
        test_file: 'find_non_domestic_assessor_by_name_spec.js'
      }

    result = my_subject.format_errors
    expect(result.first).to eq(errors)
  end

  it 'send the error test to the slack agent' do
    allow(slack_agent).to receive(:post)
    allow(ENV).to receive(:[]).with('EPB_TEAM_SLACK_URL').and_return('https://example.com/webhook')

    WebMock.stub_request(:post, 'https://example.com/webhook')
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
