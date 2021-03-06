RSpec.describe Inquisition::Outputter::Doc::TPL::DB::ActiveRecordDoctor do
  include_examples 'produceable' do
    subject(:tpl) { described_class.new([]) }
  end

  describe '.call' do
    let(:issue) do
      Inquisition::Issue.new(
        severity: Inquisition::Severity::LOW,
        message: 'book_authors has missing foreign keys, details: book_id, author_id',
        context: 'MissingUniqueIndexes',
        runner: Inquisition::ActiveRecordDoctor::Runner.new
      )
    end
    let(:collector) { instance_double(Inquisition::Outputter::Doc::TPL::Security::Collector) }
    let(:wrapper) { instance_double(Inquisition::Outputter::Doc::TPL::DB::ActiveRecordDoctor::Wrapper) }

    before do
      allow(described_class::Wrapper).to receive(:new).and_return(wrapper)
      allow(described_class).to receive(:new)

      described_class.call([issue])
    end

    it do
      expect(Inquisition::Outputter::Doc::TPL::DB::ActiveRecordDoctor::Wrapper).to have_received(:new)
        .with([issue])
    end

    it { expect(described_class).to have_received(:new).with(wrapper) }
  end

  describe Inquisition::Outputter::Doc::TPL::DB::ActiveRecordDoctor::Wrapper do
    subject(:wrapper) { described_class.new([issue, issue]) }

    let(:issue) do
      Inquisition::Issue.new(
        severity: Inquisition::Severity::LOW,
        message: 'book_authors has missing foreign keys, details: book_id, author_id',
        context: 'MissingUniqueIndexes',
        runner: Inquisition::ActiveRecordDoctor::Runner.new
      )
    end

    describe '#group' do
      it do
        expect do |block|
          wrapper.group(&block)
        end.to yield_with_args(described_class::EXPLANATIONS[issue.context], 2)
      end
    end
  end
end
