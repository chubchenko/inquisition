require 'ruby_parser/bm_sexp_processor'
require 'brakeman/processors/lib/safe_call_helper'
require 'brakeman/warning'
require 'brakeman/checks/base_check'

RSpec.describe Inquisition::Brakeman::Runner do
  let(:runner) { described_class.new }
  let(:high_confidence_warning) { Brakeman::Warning.new(confidence: 0) }
  let(:medium_confidence_warning) { Brakeman::Warning.new(confidence: 1) }
  let(:low_confidence_warning) { Brakeman::Warning.new(confidence: 2) }
  let(:warnings_array) { [high_confidence_warning, medium_confidence_warning, low_confidence_warning] }

  describe '#call' do
    before do
      allow(Brakeman).to receive_message_chain(:run, :run_checks, :warnings).and_return(warnings_array)
      allow(high_confidence_warning.file).to receive(:relative)
    end

    it 'returns instance of array' do
      expect(runner.call).to be_instance_of(Array)
    end

    it 'returns warnings-quantity-size array' do
      rand(99..999).times { warnings_array << low_confidence_warning }
      expect(runner.call.count).to eq(warnings_array.size)
    end

    it 'consists of Issue instances' do
      expect(runner.call.first).to be_instance_of(Inquisition::Issue)
    end

    it 'sets valid issue level' do
      expect(runner.call[0].instance_variable_get(:@level)).to eq(Inquisition::Issue::ISSUE_LEVELS[:high])
      expect(runner.call[1].instance_variable_get(:@level)).to eq(Inquisition::Issue::ISSUE_LEVELS[:medium])
      expect(runner.call[2].instance_variable_get(:@level)).to eq(Inquisition::Issue::ISSUE_LEVELS[:low])
    end
  end
end
