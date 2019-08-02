require 'brakeman/scanner'

RSpec.describe Inquisition::Brakeman::Runner do
  let(:runner) { described_class.new }
  let(:path) { 'foo/bar' }
  let(:file) { instance_double(Brakeman::FilePath, relative: path) }
  let(:major_warning) { instance_double(Brakeman::Warning, confidence: 0, line: nil, file: file, message: nil) }
  let(:medium_warning) { instance_double(Brakeman::Warning, confidence: 1, line: nil, file: file, message: nil) }
  let(:minor_warning) { instance_double(Brakeman::Warning, confidence: 2, line: nil, file: file, message: nil) }

  let(:high_severity_issue) { { severity: :high, path: path, line: nil, message: nil, runner: nil } }
  let(:medium_severity_issue) { { severity: :medium, path: path, line: nil, message: nil, runner: nil } }
  let(:low_severity_issue) { { severity: :low, path: path, line: nil, message: nil, runner: nil } }

  let(:warnings) { [major_warning, medium_warning, minor_warning] }
  let(:issues) { [high_severity_issue, medium_severity_issue, low_severity_issue] }

  describe '#call' do
    before do
      tracker = instance_double(Brakeman::Tracker)
      allow(Brakeman).to receive(:run).and_return(tracker)
      allow(tracker).to receive(:warnings).and_return(warnings)
    end

    it 'returns array with issues' do
      runner.call.each_with_index do |issue, index|
        # TODO: will be fixed in the next PR
        # expect(issue.instance_variable_get(:@severity)).to eq(issues[index][:severity])
        expect(issue.instance_variable_get(:@path)).to eq(issues[index][:path])
      end
    end
  end

  include_examples 'enablable', 'brakeman'
end
