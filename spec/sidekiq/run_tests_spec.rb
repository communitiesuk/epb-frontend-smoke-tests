RSpec.describe Worker::RunTests do
  before do
    allow($stdout).to receive(:puts)
    WebMock.enable!
    allow(ENV).to receive(:[])
  end
  after { WebMock.disable! }


  describe '#perform' do
    it "invokes the perform action of the worker without error" do
      expect { described_class.new.perform }.not_to raise_error
    end

  end

end
