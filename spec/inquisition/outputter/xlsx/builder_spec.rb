RSpec.describe Inquisition::Outputter::Xlsx::Builder do
  describe '.call' do
    before do
      allow(builder).to receive(:call)
      allow(described_class).to receive(:new).and_return(builder)
      described_class.call([])
    end

    let(:builder) { instance_double(described_class) }

    it { expect(builder).to have_received(:call) }
  end

  describe '#call' do
    subject(:builder) { described_class.new([], file) }

    let(:file) { instance_double(Inquisition::Outputter::Xlsx::File, path: 'inquisition/DUMMY.xlsx') }
    let(:table) { instance_double(Inquisition::Outputter::Xlsx::Table) }
    let(:package) { instance_double Axlsx::Package }
    let(:workbook) { instance_double(Axlsx::Workbook) }
    let(:sheet) { instance_double(Axlsx::Worksheet) }

    before do
      allow(Axlsx::Package).to receive(:new).and_return(package)
      allow(package).to receive(:tap).and_yield(package).and_return(package)
      allow(package).to receive(:serialize)
      allow(package).to receive(:workbook).and_return(workbook)

      allow(workbook).to receive(:add_worksheet).with(name: 'GEMFILE').and_return(sheet)
      allow(sheet).to receive(:add_row)

      allow(Inquisition::Outputter::Xlsx::Table).to receive(:new).and_return(table)
      allow(table).to receive(:each).and_yield(Inquisition::Outputter::Xlsx::Header.new)
    end

    it 'populates workbook' do
      builder.call
      expect(sheet).to have_received(:add_row).with(Inquisition::Outputter::Xlsx::Header.new.to_a)
    end

    it 'serializes workbook' do
      builder.call
      expect(package).to have_received(:serialize).with('inquisition/DUMMY.xlsx')
    end
  end
end
