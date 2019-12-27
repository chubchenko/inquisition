RSpec.describe Inquisition::Outputter::Doc::TPL::Stack do
  subject(:stack) { described_class.new }

  describe '#produce' do
    it { expect(stack.produce).to be_an_instance_of(Binding) }
  end

  describe '#ruby_version' do
    it { expect(stack.ruby_version).to eq(RUBY_VERSION) }
  end

  describe '#rails_version' do
    it { expect(stack.rails_version).to eq('5.2.4.1') }
  end

  describe '#db' do
    let(:adapter) { instance_double('ActiveRecord::ConnectionAdapters::PostgreSQLAdapter', adapter_name: 'test') }

    before do
      allow(ActiveRecord::Base).to receive(:connection).and_return(adapter)
      allow(OpenStruct).to receive(:new).with(adapter_name: adapter.adapter_name)
      stack.db
    end

    it 'returns instance of OpenStruct with db adapter' do
      expect(OpenStruct).to have_received(:new).with(adapter_name: adapter.adapter_name)
    end
  end

  describe '#jobs' do
    subject(:stack) { described_class.new }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      stack.jobs
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::TPL::Stack::Jobs)
      )
    end
  end

  describe '#exception' do
    subject(:stack) { described_class.new }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      stack.exception
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::TPL::Stack::Exception)
      )
    end
  end

  describe '#instrumentation' do
    subject(:stack) { described_class.new }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      stack.instrumentation
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::TPL::Stack::Instrumentation)
      )
    end
  end
end
