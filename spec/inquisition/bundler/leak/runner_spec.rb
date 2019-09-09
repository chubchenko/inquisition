RSpec.describe Inquisition::Bundler::Leak::Runner do
  include_examples 'enablable', 'bundler_leak'

  describe '#call' do
    subject(:runner) { described_class.new }

    let(:scanner) { instance_double(Bundler::Plumber::Scanner) }
    let(:test_gem) { instance_double(Bundler::LazySpecification) }
    let(:advisory) { instance_double(Bundler::Plumber::Advisory, title: 'Memory leak in formatter middleware') }
    let(:unpatched_gem) { Bundler::Plumber::Scanner::UnpatchedGem.new(test_gem, advisory) }

    let(:issue) do
      Inquisition::Issue.new(
        line: nil,
        category: :performance,
        severity: :low,
        path: 'Gemfile.lock',
        message: 'Memory leak in formatter middleware',
        runner: nil
      )
    end

    before do
      allow(scanner).to receive(:scan).and_return([unpatched_gem].to_enum)
      allow(Bundler::Plumber::Scanner).to receive(:new).with(Rails.root.to_s).and_return(scanner)
    end

    it do
      expect(runner.call).to match_array([issue])
    end
  end
end
