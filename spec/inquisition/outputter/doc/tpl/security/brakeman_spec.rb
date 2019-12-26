RSpec.describe Inquisition::Outputter::Doc::TPL::Security::Brakeman do
  include_examples 'produceable' do
    subject(:tpl) { described_class.new([]) }
  end

  describe '.call' do
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
    let(:collector) { instance_double(Inquisition::Outputter::Doc::TPL::Security::Collector) }
    let(:wrapper) { instance_double(Inquisition::Outputter::Doc::TPL::Security::Brakeman::Wrapper) }

    before do
      allow(Inquisition::Outputter::Doc::TPL::Security::Brakeman::Wrapper).to receive(:new).and_return(wrapper)
      allow(described_class).to receive(:new)

      described_class.call([issue])
    end

    it do
      expect(Inquisition::Outputter::Doc::TPL::Security::Brakeman::Wrapper).to have_received(:new).with(
        [issue]
      )
    end

    it { expect(described_class).to have_received(:new).with(wrapper) }
  end

  describe Inquisition::Outputter::Doc::TPL::Security::Brakeman::Wrapper do
    subject(:wrapper) { described_class.new([issue, issue]) }

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

    describe '#tally' do
      it do
        expect do |block|
          wrapper.tally(&block)
        end.to yield_with_args('Cross-Site Scripting', 2)
      end
    end
  end
end
