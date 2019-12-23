RSpec.describe Inquisition::Outputter::Doc::TPL::Stack do
  subject(:stack) { described_class.new }

  describe '#produce' do
    it { expect(stack.produce).to be_an_instance_of(Binding) }
  end

  describe '#database_adapter' do
    subject(:database_adapter) { described_class.new.database_adapter }

    let(:db_name) { 'postgres' }
    let(:rails_config) { instance_double(Rails::Application::Configuration, database_configuration: db_config) }
    let(:db_config) { { 'default' => { 'adapter' => db_name } } }

    before { allow(Rails).to receive(:configuration).and_return(rails_config) }

    it 'returns call database configuration' do
      expect(database_adapter).to eq(db_name)
    end
  end
end
