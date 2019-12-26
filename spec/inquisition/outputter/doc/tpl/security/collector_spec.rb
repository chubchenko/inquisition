RSpec.describe Inquisition::Outputter::Doc::TPL::Security::Collector do
  subject(:collector) { described_class.new(issues, Inquisition::Brakeman::Runner) }

  describe '#call' do
    let(:klass) { Inquisition::Brakeman::Runner }
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
    let(:issues) do
      [
        issue,
        Inquisition::Issue.new(
          path: nil,
          line: nil,
          severity: Inquisition::Severity::MEDIUM,
          category: Inquisition::Category::SECURITY,
          message: 'Insecure Source URI found: http://rubygems.org/',
          runner: Inquisition::Bundler::Audit::Runner.new
        )
      ]
    end

    it 'returns collection with the specified class' do
      expect(collector.call).to match_array(issue)
    end
  end
end
