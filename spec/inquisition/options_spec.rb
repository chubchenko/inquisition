RSpec.describe Inquisition::Options do
  describe '.parse' do
    let(:options) { instance_double(described_class) }
    let(:arguments) { ['-v'] }

    before do
      allow(options).to receive(:parse)
      allow(described_class).to receive(:new).and_return(options)
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

  %w[-v --version].each do |option|
    it 'sets the `:executor` option with the `Version` invocation' do
      options = described_class.parse([option])

      expect(options.options[:executor]).to be_instance_of(Inquisition::Executor::Version)
    end
  end

  %w[-h --help].each do |option|
    it 'sets the `:executor` option with the `Help` invocation' do
      options = described_class.parse([option])

      expect(options.options[:executor]).to be_instance_of(Inquisition::Executor::Help)
    end
  end

  %w[-i --init].each do |option|
    it 'sets the `:executor` option with the `InitConfig` invocation' do
      options = described_class.parse([option])

      expect(options.options[:executor]).to be_instance_of(Inquisition::Executor::InitConfig)
    end
  end
end
