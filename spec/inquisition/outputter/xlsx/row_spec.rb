RSpec.describe Inquisition::Outputter::Xlsx::Row do
  let(:row) { described_class.new }

  describe '#to_a' do
    it { expect { row.to_a }.to raise_error(NotImplementedError) }
  end
end
