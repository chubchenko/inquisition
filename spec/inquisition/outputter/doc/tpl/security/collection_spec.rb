RSpec.describe Inquisition::Outputter::Doc::TPL::Security::Collection do
  subject(:collection) { described_class.new(issues) }

  describe '#high' do
    context 'when there are not any issues with high severity' do
      let(:issues) { [] }

      it { expect(collection.high).to be_empty }
    end

    context 'when there are at least one issues with high severity' do
      let(:issues) do
        [
          issue,
          Inquisition::Issue.new(
            category: Inquisition::Category::SECURITY,
            path: 'app/controllers/application_controller.rb',
            line: 6,
            severity: Inquisition::Severity::MEDIUM,
            message: 'User controlled method execution',
            context: 'Remote Code Execution',
            runner: Inquisition::Brakeman::Runner.new
          )
        ]
      end
      let(:issue) do
        Inquisition::Issue.new(
          category: Inquisition::Category::SECURITY,
          path: 'app/controllers/users_controller.rb',
          line: 42,
          severity: Inquisition::Severity::HIGH,
          message: 'Potentially dangerous key allowed for mass assignment',
          context: 'Cross-Site Scripting',
          runner: Inquisition::Brakeman::Runner.new
        )
      end

      it { expect(collection.high).to match_array(issue) }
    end
  end

  describe '#medium' do
    context 'when there are not any issues with medium severity' do
      let(:issues) { [] }

      it { expect(collection.medium).to be_empty }
    end

    context 'when there are at least one issues with medium severity' do
      let(:issues) do
        [
          issue,
          Inquisition::Issue.new(
            category: Inquisition::Category::SECURITY,
            path: 'app/controllers/application_controller.rb',
            line: 6,
            severity: Inquisition::Severity::HIGH,
            message: 'User controlled method execution',
            context: 'Remote Code Execution',
            runner: Inquisition::Brakeman::Runner.new
          )
        ]
      end
      let(:issue) do
        Inquisition::Issue.new(
          category: Inquisition::Category::SECURITY,
          path: 'app/controllers/users_controller.rb',
          line: 42,
          severity: Inquisition::Severity::MEDIUM,
          message: 'Potentially dangerous key allowed for mass assignment',
          context: 'Cross-Site Scripting',
          runner: Inquisition::Brakeman::Runner.new
        )
      end

      it { expect(collection.medium).to match_array(issue) }
    end
  end

  describe '#low' do
    context 'when there are not any issues with low severity' do
      let(:issues) { [] }

      it { expect(collection.low).to be_empty }
    end

    context 'when there are at least one issues with low severity' do
      let(:issues) do
        [
          issue,
          Inquisition::Issue.new(
            category: Inquisition::Category::SECURITY,
            path: 'app/controllers/application_controller.rb',
            line: 6,
            severity: Inquisition::Severity::MEDIUM,
            message: 'User controlled method execution',
            context: 'Remote Code Execution',
            runner: Inquisition::Brakeman::Runner.new
          )
        ]
      end
      let(:issue) do
        Inquisition::Issue.new(
          category: Inquisition::Category::SECURITY,
          path: 'app/controllers/users_controller.rb',
          line: 42,
          severity: Inquisition::Severity::LOW,
          message: 'Potentially dangerous key allowed for mass assignment',
          context: 'Cross-Site Scripting',
          runner: Inquisition::Brakeman::Runner.new
        )
      end

      it { expect(collection.low).to match_array(issue) }
    end
  end
end
