require 'ruby_parser/bm_sexp_processor'
require 'brakeman/processors/lib/safe_call_helper'
require 'brakeman/warning'
require 'brakeman/checks/base_check'

RSpec.describe Inquisition::Brakeman::Runner do
  let(:runner) { described_class.new }
  let(:warning) { Brakeman::Warning.new(confidence: 0) }
  let(:another_warning) { Brakeman::Warning.new(confidence: 1) }
  let(:warnings) { [warning, another_warning] }

  describe '#call' do
    before do
      allow(Brakeman).to receive_message_chain(:run, :run_checks, :warnings).and_return(warnings)
      allow(warning.file).to receive(:relative)
    end

    it 'returns instance of array' do
      expect(runner.call).to be_instance_of(Array)
    end

    it 'returns warnings-quantity-size array' do
      expect(runner.call.count).to eq(warnings.size)
    end

    it 'consists of Issue instances' do
      expect(runner.call.first).to be_instance_of(Inquisition::Issue)
    end

    it 'sets issue level' do
      expect(runner.call.first.instance_variable_get(:@level)).to eq(Inquisition::Issue::ISSUE_LEVELS[:high])
      expect(runner.call.last.instance_variable_get(:@level)).to eq(Inquisition::Issue::ISSUE_LEVELS[:medium])
    end
  end
end
