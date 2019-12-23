RSpec.describe Inquisition::Outputter::Doc::TPL::Security::Brakeman do
  describe '.call' do
    subject(:call) { described_class.call([]) }

    let(:brakeman) { instance_double(described_class) }

    it 'described class extends by simple delegator' do
      expect(described_class).to be < SimpleDelegator
    end

    context 'when calling method call' do
      before do
        allow(described_class::Collection).to receive(:new).with([])
        allow(described_class).to receive(:new).and_return(brakeman)
        described_class.call([])
      end

      it 'returns instance of Collection' do
        expect(described_class::Collection).to have_received(:new).with([])
      end
    end
  end

  describe Inquisition::Outputter::Doc::TPL::Security::Brakeman::Collection do
    describe '#tally' do
      subject(:tally) do
        described_class.new(issues).tally do |type, count|
          "#{type}: #{count}"
        end
      end

      let(:issues) { [brakeman_issue, active_record_doctor_issue] }
      let(:brakeman_issue) do
        instance_double(Inquisition::Issue, runner: brakeman_runner, severity: severity, context: 'Mass Assignment')
      end
      let(:severity) { instance_double(Inquisition::Severity, name: :high) }
      let(:active_record_doctor_issue) { instance_double(Inquisition::Issue, runner: active_record_doctor) }
      let(:brakeman_runner) { instance_double(Inquisition::Brakeman::Runner) }
      let(:active_record_doctor) { instance_double(Inquisition::ActiveRecordDoctor::Runner) }
      let(:instance_runner) { ::Inquisition::Brakeman::Runner.new }
      let(:result_params) { { 'Mass Assignment' => [brakeman_issue] } }

      before { allow(brakeman_issue).to receive(:runner).and_return(instance_runner) }

      it 'returns issues by name runner' do
        expect(tally).to eq(result_params)
      end
    end

    describe '#count' do
      subject(:count) { described_class.new(issues).count }

      let(:issues) { [brakeman_issue, active_record_doctor_issue] }
      let(:brakeman_issue) do
        instance_double(Inquisition::Issue, runner: brakeman_runner, severity: severity)
      end
      let(:severity) { instance_double(Inquisition::Severity, name: :high) }
      let(:active_record_doctor_issue) { instance_double(Inquisition::Issue, runner: active_record_doctor) }
      let(:brakeman_runner) { instance_double(Inquisition::Brakeman::Runner) }
      let(:active_record_doctor) { instance_double(Inquisition::ActiveRecordDoctor::Runner) }
      let(:instance_runner) { ::Inquisition::Brakeman::Runner.new }

      before { allow(brakeman_issue).to receive(:runner).and_return(instance_runner) }

      it 'returns issues by name runner' do
        expect(count).to eq(1)
      end
    end

    describe '#count' do
      subject(:high) { described_class.new(issues).high }

      let(:issues) { [brakeman_issue, active_record_doctor_issue] }
      let(:brakeman_issue) do
        instance_double(Inquisition::Issue, runner: brakeman_runner, severity: severity)
      end
      let(:severity) { instance_double(Inquisition::Severity, name: :high) }
      let(:active_record_doctor_issue) { instance_double(Inquisition::Issue, runner: active_record_doctor) }
      let(:brakeman_runner) { instance_double(Inquisition::Brakeman::Runner) }
      let(:active_record_doctor) { instance_double(Inquisition::ActiveRecordDoctor::Runner) }
      let(:instance_runner) { ::Inquisition::Brakeman::Runner.new }

      before { allow(brakeman_issue).to receive(:runner).and_return(instance_runner) }

      it 'returns issues by name runner' do
        expect(high).to eq([brakeman_issue])
      end
    end
  end
end
