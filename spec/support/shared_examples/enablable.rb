RSpec.shared_examples 'enablable' do |badge|
  describe '.enabled?' do
    subject { described_class }

    context 'when the file is missing' do
      it { is_expected.not_to be_enabled }
    end

    context 'when a value set to false' do
      let(:configuration) { instance_double(Inquisition::Configuration) }

      before do
        allow(configuration).to receive(:to_h).and_return('plugins' => { badge => { 'enabled' => false } })
        allow(Inquisition::Configuration).to receive(:instance).and_return(configuration)
      end

      it { is_expected.not_to be_enabled }
    end

    context 'when a value set to true' do
      let(:configuration) { instance_double(Inquisition::Configuration) }

      before do
        allow(configuration).to receive(:to_h).and_return('plugins' => { badge => { 'enabled' => true } })
        allow(Inquisition::Configuration).to receive(:instance).and_return(configuration)
      end

      it { is_expected.to be_enabled }
    end
  end
end
