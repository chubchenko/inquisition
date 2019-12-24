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
    it
  end

  describe '#jobs' do
    subject(:stack) { described_class.new() }

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

  describe '#exception_and_instrumentation' do
    it
  end
end
