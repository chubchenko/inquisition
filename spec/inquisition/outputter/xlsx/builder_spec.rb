RSpec.describe Inquisition::Outputter::Xlsx::Builder do
  describe '.call' do
    let(:builder) { instance_double(described_class) }

    before do
      allow(builder).to receive(:call)
      allow(described_class).to receive(:new).and_return(builder)
      described_class.call([])
    end

    it { expect(builder).to have_received(:call) }
  end

  describe '#call' do
    subject(:builder) { described_class.new([]) }

    before { builder.call }

    after { FileUtils.rm_rf(Inquisition::Configuration.instance.output_path) }

    it 'creates a xlsx file' do
      expect(File).to exist(
        File.join(Inquisition::Configuration.instance.output_path, 'DUMMY.xlsx')
      )
    end
  end
end
