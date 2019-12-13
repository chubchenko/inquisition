RSpec.describe Inquisition::Outputter::Doc::Templates::BaseTemplate do
  describe '#collect_issues' do
    subject(:collect_issues) { described_class.new(issues).collect_issues(runner_name) }

    before do
      allow(brakeman_runner).to receive(:class).and_return(Inquisition::Brakeman::Runner)
      allow(active_record_doctor).to receive(:class).and_return(Inquisition::ActiveRecordDoctor::Runner)
    end

    context 'when get issues by runner name' do
      let(:runner_name) { 'brakeman' }
      let(:issues) { [brakeman_issue, active_record_doctor_issue] }
      let(:brakeman_issue) { instance_double(Inquisition::Issue, runner: brakeman_runner) }
      let(:active_record_doctor_issue) { instance_double(Inquisition::Issue, runner: active_record_doctor) }
      let(:brakeman_runner) { instance_double(Inquisition::Brakeman::Runner) }
      let(:active_record_doctor) { instance_double(Inquisition::ActiveRecordDoctor::Runner) }

      it 'returns issues by name runner' do
        expect(collect_issues).to eq([issues.first])
      end
    end

    context 'when do not get issues by runner name' do
      let(:runner_name) { 'rubocop' }
      let(:issues) { [brakeman_issue, active_record_doctor_issue] }
      let(:brakeman_issue) { instance_double(Inquisition::Issue, runner: brakeman_runner) }
      let(:active_record_doctor_issue) { instance_double(Inquisition::Issue, runner: active_record_doctor) }
      let(:brakeman_runner) { instance_double(Inquisition::Brakeman::Runner) }
      let(:active_record_doctor) { instance_double(Inquisition::ActiveRecordDoctor::Runner) }

      it 'returns empty array' do
        expect(collect_issues).to be_empty
      end
    end
  end

  describe '#take_issues_by_difficulty' do
    subject(:take_issues_by_difficulty) { described_class.new(nil).take_issues_by_difficulty(issues, difficult) }

    let(:issues) { [brakeman_issue, active_record_doctor_issue] }
    let(:brakeman_issue) { instance_double(Inquisition::Issue, severity: severity_low) }
    let(:active_record_doctor_issue) { instance_double(Inquisition::Issue, severity: severity_high) }
    let(:severity_low) { instance_double(Inquisition::Severity, name: :low) }
    let(:severity_high) { instance_double(Inquisition::Severity, name: :high) }

    context 'when get high issues' do
      let(:difficult) { :high }

      it 'returns issues with high difficulty' do
        expect(take_issues_by_difficulty).to eq([active_record_doctor_issue])
      end
    end

    context 'when not exists issues with difficulty' do
      let(:difficult) { :medium }

      it 'returns empty array' do
        expect(take_issues_by_difficulty).to be_empty
      end
    end
  end
end
