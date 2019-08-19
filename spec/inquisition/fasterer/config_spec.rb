RSpec.describe Inquisition::Fasterer::Config do
  describe '#nil_file' do
    it 'returns default config' do
      expect(described_class.new.nil_file).to include(
        'speedups' => a_kind_of(Hash),
        'exclude_paths' => a_kind_of(Array)
      )
    end
  end
end
