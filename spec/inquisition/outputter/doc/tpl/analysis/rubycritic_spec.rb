RSpec.describe Inquisition::Outputter::Doc::TPL::Analysis::Rubycritic do
  include_examples 'produceable' do
    subject(:tpl) { described_class.new([]) }
  end

  describe '.call' do
    let(:issue) do
      Inquisition::Issue.new(
        category: Inquisition::Category::SECURITY,
        path: 'app/controllers/users_controller.rb',
        line: 42,
        severity: Inquisition::Severity::LOW,
        message: 'context#with database columns has a flog score of 35',
        context: 'HighComplexity',
        runner: Inquisition::Rubycritic::Runner.new
      )
    end

    let(:collector) { instance_double(Inquisition::Outputter::Doc::TPL::Security::Collector) }
    let(:wrapper) { instance_double(Inquisition::Outputter::Doc::TPL::Analysis::Rubycritic::Wrapper) }

    before do
      allow(Inquisition::Outputter::Doc::TPL::Analysis::Rubycritic::Wrapper).to receive(:new).and_return(wrapper)
      allow(described_class).to receive(:new)

      described_class.call([issue])
    end

    it do
      expect(Inquisition::Outputter::Doc::TPL::Analysis::Rubycritic::Wrapper).to have_received(:new).with(
        [issue]
      )
    end

    it { expect(described_class).to have_received(:new).with(wrapper) }
  end

  describe '#types' do
    subject(:rubycritic) { described_class.new([issue, issue]) }

    let(:issue) do
      Inquisition::Issue.new(
        category: Inquisition::Category::SECURITY,
        path: 'app/controllers/users_controller.rb',
        line: 42,
        severity: Inquisition::Severity::LOW,
        message: 'context#with database columns has a flog score of 35',
        context: 'HighComplexity',
        runner: Inquisition::Rubycritic::Runner.new
      )
    end

    it do
      expect do |block|
        rubycritic.types([issue, issue], &block)
      end.to yield_with_args('HighComplexity', 2)
    end
  end

  describe '#score' do
    subject(:score) { described_class.new(issues).score }

    context 'when issue exists' do
      let(:issues) { [issue] }
      let(:total_score) { 10 }
      let(:issue) do
        Inquisition::Issue.new(
          category: Inquisition::Category::SECURITY,
          path: 'app/controllers/users_controller.rb',
          line: 42,
          severity: Inquisition::Severity::LOW,
          message: 'context#with database columns has a flog score of 35',
          context: 'HighComplexity',
          runner: instance_double(Inquisition::Rubycritic::Runner, common_score: total_score)
        )
      end

      it do
        expect(score).to eq(total_score)
      end
    end

    context 'when issue not exists' do
      let(:issues) { [] }

      it do
        expect(score).to eq(described_class::MIN_SCORE)
      end
    end
  end

  describe 'link' do
    subject(:link) { described_class.new([]).link }

    let(:stack) { instance_double(Inquisition::Outputter::Doc::TPL::Stack::Collector) }
    let(:struct) { double(OpenStruct, homepage: 'https://github.com/whitesmith/rubycritic') }

    before do
      allow(Inquisition::Outputter::Doc::TPL::Stack::Collector).to receive(:new).with(['rubycritic']).and_return(stack)
      allow(stack).to receive(:call).and_return([struct])
    end

    it do
      expect(link).to eq(struct.homepage)
    end
  end

  describe Inquisition::Outputter::Doc::TPL::Analysis::Rubycritic::Wrapper do
    subject(:wrapper) { described_class.new([issue, issue]) }

    let(:issue) do
      Inquisition::Issue.new(
        category: Inquisition::Category::SECURITY,
        path: 'app/controllers/users_controller.rb',
        line: 42,
        severity: Inquisition::Severity::LOW,
        message: 'context#with database columns has a flog score of 35',
        context: 'HighComplexity',
        runner: Inquisition::Rubycritic::Runner.new
      )
    end

    describe '#group' do
      it do
        expect do |block|
          wrapper.group(&block)
        end.to yield_with_args('Low', [issue, issue])
      end
    end
  end
end
