RSpec.describe Inquisition::Rubycritic::Smell do
  describe '#to_h' do
    subject(:smell) { described_class.new(*arguments) }

    let(:arguments) do
      [
        instance_double(
          RubyCritic::Smell,
          context: 'Similar code',
          message: 'found in 2 nodes',
          analyser: 'flay'
        ),
        instance_double(
          RubyCritic::Location,
          line: 42,
          pathname: Pathname.new(Rails.root.join('app', 'models', 'application_record.rb'))
        )
      ]
    end

    let(:options) do
      {
        path: 'app/models/application_record.rb',
        line: 42,
        severity: Inquisition::Severity::LOW,
        message: 'Similar code found in 2 nodes',
      }
    end

    it { expect(smell.to_h).to include(options) }
  end
end
