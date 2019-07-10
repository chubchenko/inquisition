RSpec.describe Inquisition::Core::BaseFormatter, type: :unit do
  include FormatterHelpModule

  subject { Inquisition::Core::BaseFormatter.new(unparsed_data: unparsed_data, spended_time: spended_time) }

  describe '.initialize' do
    it 'set variables' do
      expect(subject.instance_variable_get(:@unparsed_data)).to eq(unparsed_data)
      expect(subject.instance_variable_get(:@spended_time)).to eq(spended_time)
      expect(subject.instance_variable_get(:@result_hash)).to eq({})
    end
  end

  describe '#call' do
    before do
      allow(subject).to receive(:build_errors)
      allow(subject).to receive(:build_error_count)
      allow(subject).to receive(:build_total_files_count)
    end

    it 'return structured result hash' do
      expect(subject.call).to eq(structured_hash)
    end
  end
end
