RSpec.describe Inquisition::Outputter::XLSX::Builder do

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
    before { described_class.call([]) }
    after { FileUtils.rm_rf(Inquisition::Configuration.instance.output_path) }

    it 'creates xlsx file' do
      filename = "dummy_#{Date.current.strftime('%d_%m_%y')}"
      expect(File).to exist(File.join(Inquisition::Configuration.instance.output_path, filename + '.xlsx'))
    end
  end
end
