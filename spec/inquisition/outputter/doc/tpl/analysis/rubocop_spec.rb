RSpec.describe Inquisition::Outputter::Doc::TPL::Analysis::Rubocop do
  include_examples 'produceable' do
    subject(:tpl) { described_class.new([]) }
  end

  let(:issue) do
    Inquisition::Issue.new(
      category: Inquisition::Category::SECURITY,
      path: 'app/controllers/users_controller.rb',
      line: 42,
      severity: Inquisition::Severity::LOW,
      message: 'Metrics/LineLength: Line is too long. [132/125]',
      context: :unsupported,
      runner: Inquisition::Rubocop::Runner.new
    )
  end

  describe '.call' do
    let(:issue) { instance_double(Inquisition::Issue) }
    let(:collector) { instance_double(Inquisition::Outputter::Doc::TPL::Security::Collector) }

    before do
      allow(Inquisition::Outputter::Doc::TPL::Security::Collector).to receive(:new).and_return(collector)
      allow(collector).to receive(:call).and_return([issue])
      allow(described_class).to receive(:new)

      described_class.call([issue])
    end

    it do
      expect(Inquisition::Outputter::Doc::TPL::Security::Collector).to have_received(:new)
        .with([issue], ::Inquisition::Rubocop::Runner)
    end

    it { expect(described_class).to have_received(:new) }
  end

  describe 'link' do
    subject(:link) { described_class.new([]).link }

    let(:stack) { instance_double(Inquisition::Outputter::Doc::TPL::Stack::Collector) }
    let(:struct) { double(OpenStruct, homepage: 'https://github.com/rubocop-hq/rubocop') }

    before do
      allow(Inquisition::Outputter::Doc::TPL::Stack::Collector).to receive(:new).with(['rubocop']).and_return(stack)
      allow(stack).to receive(:call).and_return([struct])
    end

    it do
      expect(link).to eq(struct.homepage)
    end
  end

  describe '#extensions' do
    subject(:rubocop) { described_class.new([]) }

    let(:bundler_gems) { instance_double(Bundler::LockfileParser, dependencies: dependency) }
    let(:dependency) do
      { 'rubocop-rspec' => '', 'rubocop-performance' => '', 'rubocop-rake' => '', 'rubocop-md' => '' }
    end
    let(:absent_gem) { 'rubocop-rails' }
    let(:stack_collector) { instance_double(Inquisition::Outputter::Doc::TPL::Stack::Collector) }
    let(:struct) { double(OpenStruct, name: absent_gem, homepage: 'https://github.com/rubocop-hq/rubocop-rails') }

    before do
      allow(Bundler).to receive(:locked_gems).and_return(bundler_gems)
      allow(Inquisition::Outputter::Doc::TPL::Stack::Collector).to receive(:new)
        .with([absent_gem]).and_return(stack_collector)
      allow(stack_collector).to receive(:call).and_return([struct])
    end

    it do
      expect do |block|
        rubocop.extensions(&block)
      end.to yield_with_args(absent_gem, struct.homepage)
    end
  end

  describe '#inspect_files' do
    subject(:inspect_files) { described_class.new([issue]).inspect_files }

    let(:instance_modified_runner) do
      instance_double(Inquisition::Rubocop::RubocopModifiedRunner,
                      target_files: ['app/controllers/application_controller.rb'])
    end

    before { allow(issue.runner).to receive(:modified_runner).and_return(instance_modified_runner) }

    it { expect(inspect_files).to eq(1) }
  end

  describe '#contains_rubocop' do
    subject(:contains_rubocop) { described_class.new([]).contains_rubocop }

    let(:bundler_gems) { instance_double(Bundler::LockfileParser, dependencies: dependency) }

    before { allow(Bundler).to receive(:locked_gems).and_return(bundler_gems) }

    context 'when gem present' do
      let(:dependency) { { 'rubocop' => '' } }

      it { expect(contains_rubocop).to eq('present') }
    end

    context 'when gem absent' do
      let(:dependency) { {} }

      it { expect(contains_rubocop).to eq('absent') }
    end
  end

  describe '#autocorrect_count' do
    it
  end
end
