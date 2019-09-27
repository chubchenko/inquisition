RSpec.describe Inquisition::Executor::Version do
  let(:output) { instance_double(StringIO) }

  before { allow(output).to receive(:puts) }

  describe '#call' do
    it { expect(described_class.new.call(output)).to be_zero }

    it do
      described_class.new.call(output)

      expect(output).to have_received(:puts).with(Inquisition::Version.to_s)
    end
  end
end

RSpec.describe Inquisition::Executor::Help do
  let(:output) { instance_double(StringIO) }
  let(:options) { instance_double(OptionParser) }

  before { allow(output).to receive(:puts) }

  describe '#call' do
    it { expect(described_class.new(options).call(output)).to be_zero }

    it do
      described_class.new(options).call(output)

      expect(output).to have_received(:puts).with(options)
    end
  end
end

RSpec.describe Inquisition::Executor::Initialize do
  describe '#call' do
    let(:output) { StringIO.new }

    after(:each) do
      File.delete(File.join(Rails.root, '.inquisition.yml'))
    end

    context 'when .inquisition.yml does not exist' do
      it do
        described_class.new(output: output).call

        expect(output.string).to start_with('Writing new .inquisition.yml to')
      end

      it { expect(described_class.new(output: output).call).to eq(0) }

      it 'creates a .inquisition.yml file' do
        described_class.new(output: output).call

        expect(IO.read(File.join(Rails.root, '.inquisition.yml'))).to eq(<<~YAML)
        ---
        :plugins:
          :active_record_doctor:
            :enabled: true
          :brakeman:
            :enabled: true
          :rubocop:
            :enabled: true
          :fasterer:
            :enabled: true
          :traceroute:
            :enabled: true
          :i18n_tasks:
            :enabled: true
          :factory_bot:
            :enabled: true
          :bundler_audit:
            :enabled: true
          :bundler_leak:
            :enabled: true
          :rails_best_practices:
            :enabled: true
          :lol_dba:
            :enabled: true
          :rubycritic:
            :enabled: true
        YAML
      end
    end

    context 'when .inquisition.yml already exists' do
      before { File.open(File.join(Rails.root, '.inquisition.yml'), 'w') {} }

      it do
        described_class.new(output: output).call

        expect(output.string).to start_with('.inquisition.yml already exists at')
      end

      it { expect(described_class.new(output: output).call).to eq(1) }
    end
  end
end
