RSpec.describe Inquisition::Outputter::Doc::ViewHelper do
  describe '#workers_with_jobs' do
    subject(:workers_with_jobs) { described_class.new(nil).workers_with_jobs }

    before { allow(Gem).to receive(:loaded_specs).and_return(gem_specification) }

    context 'when gems exists in rails app' do
      let(:params_const) { { gems: ['rails'] } }
      let(:gem_specification) { { 'rails' => 'object' } }

      before { stub_const('Inquisition::Outputter::Doc::TechnologyStack::WORKERS_WITH_JOBS', params_const) }

      it 'returns exists gem' do
        expect(workers_with_jobs.first).to be_kind_of(Inquisition::Outputter::Doc::GemDetails)
      end
    end

    context 'when gems not exists in rails app' do
      let(:params_const) { { gems: ['test_name_gem'], exception: 'error' } }
      let(:gem_specification) { {} }

      before { stub_const('Inquisition::Outputter::Doc::TechnologyStack::WORKERS_WITH_JOBS', params_const) }

      it 'returns message about not exists gem' do
        expect(workers_with_jobs).to eq([{ exception: 'error' }])
      end
    end
  end

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

  describe '#group_brakeman_issues_by_warnings' do
    subject(:group_brakeman_issues_by_warnings) { described_class.new(issues).group_brakeman_issues_by_warnings }

    let(:issues) { [brakeman_issue, brakeman_issue_first] }
    let(:brakeman_issue) { instance_double(Inquisition::Issue, aditional_data: warning, runner: brakeman_runner) }
    let(:brakeman_issue_first) { instance_double(Inquisition::Issue, aditional_data: warning, runner: brakeman_runner) }
    let(:result_method_call) { { 'test' => [brakeman_issue, brakeman_issue_first] } }
    let(:brakeman_runner) { instance_double(Inquisition::Brakeman::Runner) }
    let(:warning) { instance_double('Brakeman::Warning', warning_type: 'test') }
    let(:badge) { instance_double('Inquisition::Badge', name: 'brakeman') }

    before { allow(Inquisition::Badge).to receive(:for).and_return(badge) }

    it 'returns grouped issues brakeman by warning' do
      expect(group_brakeman_issues_by_warnings).to eq(result_method_call)
    end
  end

  describe '#group_bundler_audit_issues' do
    subject(:group_bundler_audit_issues) { described_class.new(issues).group_bundler_audit_issues }

    let(:issues) { [bundler_issue, bundler_issue_first] }
    let(:bundler_issue) { instance_double(Inquisition::Issue, aditional_data: scanner, runner: runner) }
    let(:bundler_issue_first) { instance_double(Inquisition::Issue, aditional_data: scanner, runner: runner) }
    let(:runner) { instance_double(Inquisition::Bundler::Audit::Runner) }
    let(:scanner) { instance_double(Bundler::Audit::Scanner::UnpatchedGem, gem: gem) }
    let(:gem) { instance_double(Bundler::LazySpecification, name: 'test') }
    let(:badge) { instance_double('Inquisition::Badge', name: 'bundler_audit') }
    let(:gem_details) { instance_double(Inquisition::Outputter::Doc::GemDetails, name: gem.name, link: 'test_link') }

    before do
      allow(Inquisition::Badge).to receive(:for).and_return(badge)
      allow(Inquisition::Outputter::Doc::GemDetails).to receive(:new).and_return(gem_details)
    end

    it 'returns grouped bundler audit by gem name' do
      expect(group_bundler_audit_issues).to eq({ name: gem_details.name,
                                                 link: gem_details.link } => [bundler_issue, bundler_issue_first])
    end
  end
end
