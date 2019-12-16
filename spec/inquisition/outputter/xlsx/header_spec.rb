RSpec.describe Inquisition::Outputter::Xlsx::Header do
  let(:header) { described_class.new }

  describe '#to_a' do
    it do
      expect(header.to_a).to match_array(
        ['Name', 'Source Code URI', 'Current Version', 'Newest Version', 'Outdated', 'Environment', 'Status']
      )
    end
  end
end
