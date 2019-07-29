RSpec.describe Inquisition::Issue do
  let(:valid_attributes) do
    { level: Inquisition::Issue::LEVELS[:low], file: 'file', line: 123, runner: 'runner', message: 'foo bar' }
  end

  let(:valid_attributes_with_different_runner) do
    { level: Inquisition::Issue::LEVELS[:low], file: 'file', line: 123, runner: 'runner_2', message: 'foo bar' }
  end

  let(:valid_attributes_with_different_level) do
    { level: Inquisition::Issue::LEVELS[:high], file: 'file', line: 123, runner: 'runner_2', message: 'foo bar' }
  end

  let(:invalid_attributes) { { level: 'foo', file: 'file', line: 123, runner: 'runner', message: 'foo bar' } }

  let(:valid_issue) { described_class.new(**valid_attributes) }
  let(:different_level_valid_issue) { described_class.new(**valid_attributes_with_different_level) }
  let(:different_runner_valid_issue) { described_class.new(**valid_attributes_with_different_runner) }

  describe '#initialize' do
    it 'sets instance variables' do
      expect(valid_issue.level).to eq(valid_attributes[:level])
      expect(valid_issue.file).to eq(valid_attributes[:file])
      expect(valid_issue.line).to eq(valid_attributes[:line])
      expect(valid_issue.message).to eq(valid_attributes[:message])
    end

    it 'validates issue level' do
      expect { described_class.new(**invalid_attributes) }.to raise_error(ArgumentError, 'Incorrect issue level')
    end
  end

  describe '#==' do
    it 'compares issues ignoring issue-runner' do
      expect(valid_issue == different_runner_valid_issue).to eq(true)
      expect(valid_issue == different_level_valid_issue).to eq(false)
    end
  end

  describe '#eql?' do
    it 'do the same operator == do' do
      expect(valid_issue.eql?(different_runner_valid_issue)).to eq(true)
      expect(valid_issue.eql?(different_level_valid_issue)).to eq(false)
    end
  end

  describe '#hash' do
    it 'sets hash method by XOR comparable attributes of issue' do
      expect(valid_issue.hash == different_runner_valid_issue.hash).to eq(true)
      expect(valid_issue.hash == different_level_valid_issue.hash).to eq(false)
    end
  end
end
