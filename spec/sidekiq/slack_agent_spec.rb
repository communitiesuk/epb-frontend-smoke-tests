# frozen_string_literal: true

describe SlackGateway do
  let(:gateway) { described_class.new }

  before do
    WebMock.enable!
    WebMock.reset!
  end

  after do
    WebMock.disable!
  end

  describe '#post' do
    it 'send a message to slack API' do
      allow(ENV).to receive(:[]).with('EPB_TEAM_SLACK_URL').and_return('https://example.com/webhook')
      slack_request = WebMock.stub_request(:post, 'https://example.com/webhook')
                             .to_return(status: 200, headers: {})
      gateway.post('test')
      expect(slack_request).to have_been_made
    end
  end
end
