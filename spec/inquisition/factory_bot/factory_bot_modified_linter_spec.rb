RSpec.describe Inquisition::FactoryBot::FactoryBotModifiedLinter do
  describe '#call' do
    let(:factory_name) { 'factory name' }

    context 'without traits' do
      let(:linter) { described_class.new([factory]) }
      let(:factory) { instance_double(FactoryBot::Factory, name: factory_name) }
      let(:factory_error) { StandardError.new(message: 'factory error') }

      before do
        allow(FactoryBot).to receive(:public_send).with(:create, factory.name).and_raise(factory_error)
      end

      it 'returns invalid factories' do
        expect(linter.call.first.message).to eq("* #{factory_name} - #{factory_error.message} (#{factory_error.class})")
        expect(FactoryBot).to have_received(:public_send).with(:create, factory.name)
      end
    end

    context 'with traits' do
      let(:trait_name) { 'trait name' }
      let(:trait) { instance_double(FactoryBot::Trait, name: trait_name) }
      let(:factory) { FactoryBot::Factory.new(factory_name, traits: [trait]) }
      let(:linter) { described_class.new([factory], traits: true) }
      let(:trait_error) { StandardError.new(message: 'trait error') }

      before do
        allow(FactoryBot).to receive(:public_send).with(:create, factory.name).and_return([])
        factory.definition.define_trait(trait)
        allow(FactoryBot).to receive(:public_send).with(:create, factory.name, trait_name).and_raise(trait_error)
      end

      it 'returns invalid factories' do
        expect(linter.call.first.message).to eq("* #{factory.name}+#{trait_name} - #{trait_error.message} (#{trait_error.class})")
        expect(FactoryBot).to have_received(:public_send).with(:create, factory.name)
      end
    end
  end
end
