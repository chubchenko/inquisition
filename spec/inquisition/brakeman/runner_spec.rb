require 'brakeman/scanner'

RSpec.describe Inquisition::Brakeman::Runner do
  let(:runner) { described_class.new }
  let(:path) { 'foo/bar' }
  let(:file) { instance_double(Brakeman::FilePath, relative: path) }
  let(:major_warning)  { instance_double(Brakeman::Warning, confidence: 0, line: nil, file: file, message: nil) }
  let(:medium_warning) { instance_double(Brakeman::Warning, confidence: 1, line: nil, file: file, message: nil) }
  let(:minor_warning)  { instance_double(Brakeman::Warning, confidence: 2, line: nil, file: file, message: nil) }
  let(:warnings) { [major_warning, medium_warning, minor_warning] }

  let(:high_level_issue) do
    { level: Inquisition::Issue::LEVELS[:high], file: path, line: nil, message: nil, runner: nil }
  end

  let(:medium_level_issue) do
    { level: Inquisition::Issue::LEVELS[:medium], file: path, line: nil, message: nil, runner: nil }
  end

  let(:low_level_issue) do
    { level: Inquisition::Issue::LEVELS[:low], file: path, line: nil, message: nil, runner: nil }
  end

  let(:issues) { [high_level_issue, medium_level_issue, low_level_issue] }

  describe '#call' do
    before do
      tracker = instance_double(Brakeman::Tracker)
      allow(Brakeman).to receive(:run).and_return(tracker)
      allow(tracker).to receive(:warnings).and_return(warnings)
    end

    it 'returns array with issues' do
      runner.call.each_with_index do |issue, index|
        expect(issue.instance_variable_get(:@level)).to eq(issues[index][:level])
        expect(issue.instance_variable_get(:@file)).to eq(issues[index][:file])
      end
    end
  end
end
