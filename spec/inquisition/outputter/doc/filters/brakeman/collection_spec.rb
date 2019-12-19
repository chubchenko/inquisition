RSpec.describe Inquisition::Outputter::Doc::Filters::Brakeman::Collection do
  describe '#tally' do
    subject(:tally) do
      described_class.new(issues).tally do |type, count|
        "#{type}: #{count}"
      end
    end

    context 'when get issues by runner name' do
      let(:runner_name) { 'brakeman' }
      let(:issues) { [brakeman_issue, active_record_doctor_issue] }
      let(:brakeman_issue) { instance_double(Inquisition::Issue, runner: brakeman_runner,
                                             severity: severity, context: "Mass Assignment") }
      let(:severity) { instance_double(Inquisition::Severity, name: :high) }
      let(:active_record_doctor_issue) { instance_double(Inquisition::Issue, runner: active_record_doctor) }
      let(:brakeman_runner) { instance_double(Inquisition::Brakeman::Runner) }
      let(:active_record_doctor) { instance_double(Inquisition::ActiveRecordDoctor::Runner) }

      before { allow(brakeman_issue).to receive(:runner).and_return(::Inquisition::Brakeman::Runner) }

      it 'returns issues by name runner' do
        expect(tally).to eq({ "Mass Assignment" => [brakeman_issue] })
      end
    end
  end

  describe '#count' do
    subject(:count) { described_class.new(issues).count }

    context 'when get issues by runner name' do
      let(:runner_name) { 'brakeman' }
      let(:issues) { [brakeman_issue, active_record_doctor_issue] }
      let(:brakeman_issue) { instance_double(Inquisition::Issue, runner: brakeman_runner,
                                             severity: severity) }
      let(:severity) { instance_double(Inquisition::Severity, name: :high) }
      let(:active_record_doctor_issue) { instance_double(Inquisition::Issue, runner: active_record_doctor) }
      let(:brakeman_runner) { instance_double(Inquisition::Brakeman::Runner) }
      let(:active_record_doctor) { instance_double(Inquisition::ActiveRecordDoctor::Runner) }

      before { allow(brakeman_issue).to receive(:runner).and_return(::Inquisition::Brakeman::Runner) }

      it 'returns issues by name runner' do
        expect(count).to eq(1)
      end
    end
  end

  describe '#count' do
    subject(:high) { described_class.new(issues).high }

    context 'when get issues by runner name' do
      let(:runner_name) { 'brakeman' }
      let(:issues) { [brakeman_issue, active_record_doctor_issue] }
      let(:brakeman_issue) { instance_double(Inquisition::Issue, runner: brakeman_runner,
                                             severity: severity) }
      let(:severity) { instance_double(Inquisition::Severity, name: :high) }
      let(:active_record_doctor_issue) { instance_double(Inquisition::Issue, runner: active_record_doctor) }
      let(:brakeman_runner) { instance_double(Inquisition::Brakeman::Runner) }
      let(:active_record_doctor) { instance_double(Inquisition::ActiveRecordDoctor::Runner) }

      before { allow(brakeman_issue).to receive(:runner).and_return(::Inquisition::Brakeman::Runner) }

      it 'returns issues by name runner' do
        expect(high).to eq([brakeman_issue])
      end
    end
  end
end
