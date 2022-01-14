describe Helper::JourneyTestStatusCheck do
  let(:helper) { described_class.new }

  context 'when there are failures' do
    it 'returns the journey test status in a ruby object' do
      result = helper.get_failure_count('spec/fixtures/output_success.json')
      expect(result).to eq(0)
    end
  end

  context 'when there are no failures' do
    it 'returns the journey test status in a ruby object' do
      result = helper.get_failure_count('spec/fixtures/output_failure.json')
      expect(result).to eq(11)
    end
  end
end
