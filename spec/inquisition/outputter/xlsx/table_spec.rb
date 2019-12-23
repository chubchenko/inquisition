RSpec.describe Inquisition::Outputter::Xlsx::Table do
  subject(:table) { described_class.new(collector) }

  describe '#each' do
    let(:collector) { instance_double(Inquisition::Outputter::Xlsx::Collector) }
    let(:row) { instance_double(Inquisition::Outputter::Xlsx::Row) }
    let(:header) { instance_double(Inquisition::Outputter::Xlsx::Header) }

    before do
      allow(Inquisition::Outputter::Xlsx::Header).to receive(:new).and_return(header)
      allow(collector).to receive(:call).and_return([row])
    end

    it do
      expect do |block|
        table.each(&block)
      end.to yield_successive_args(header, row)
    end
  end
end
