RSpec.describe Inquisition::FactoryBot::Runner do
  include_examples 'enablable', 'factory_bot'

  describe '#call' do
    let(:runner) { described_class.new }
    let(:linter) { instance_double(Inquisition::FactoryBot::FactoryBotModifiedLinter) }
    let(:factory) { instance_double(FactoryBot::Factory) }

    let(:factory_error) do
      instance_double(FactoryBot::Linter::FactoryError, location: factory, message: 'factory error')
    end

    let(:factory_trait_error) do
      instance_double(FactoryBot::Linter::FactoryTraitError, location: factory, message: 'factory trait error')
    end

    before do
      allow(FactoryBot).to receive(:factories).and_return([factory])

      allow(Inquisition::FactoryBot::FactoryBotModifiedLinter).to receive(:new).with(
        [factory],
        traits: true
      ).and_return(linter)

      allow(linter).to receive(:call).and_return([factory_error, factory_trait_error])
    end

    it 'returns array with issues' do
      expect(runner.call).to contain_exactly(
        Inquisition::Issue.new(
          path: factory,
          line: nil,
          severity: Inquisition::Severity::LOW,
          category: Inquisition::Category::BUG_RISK,
          message: 'factory error',
          runner: nil
        ),
        Inquisition::Issue.new(
          path: factory,
          line: nil,
          severity: Inquisition::Severity::LOW,
          category: Inquisition::Category::BUG_RISK,
          message: 'factory trait error',
          runner: nil
        )
      )
    end
  end
end
