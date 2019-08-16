RSpec.describe Inquisition::Options do
  describe '.parse' do
    let(:options) { instance_double(Inquisition::Options) }
    let(:arguments) { ['-v'] }

    before do
      allow(options).to receive(:parse)
      allow(Inquisition::Options).to receive(:new).and_return(options)
      described_class.parse(arguments)
    end

    it { expect(described_class).to have_received(:new).with(arguments) }

    it { expect(options).to have_received(:parse) }
  end

  %w[--format -f].each do |option|
    describe option do
      it 'adds outputter' do
        expect do
          described_class.parse([option, 'p'])
        end.to change(Inquisition::Configuration.instance.collection, :length).by(1)
      end
    end
  end
end
