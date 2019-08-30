RSpec.describe Inquisition::RailsBestPractices::Issue do
  describe '#to_h' do
    subject(:issue) { described_class.new(error) }

    let(:message) { 'test message' }
    let(:path) { 'test path' }
    let(:line) { '1' }

    let(:error) do
      instance_double(
        RailsBestPractices::Core::Error,
        short_filename: path,
        line_number: line,
        message: message,
        type: 'RailsBestPractices::Reviews::AddModelVirtualAttributeReview'
      )
    end

    let(:options) { { category: :complexity, severity: :low, message: message, path: path, line: line.to_i } }

    it { expect(issue.to_h).to include(options) }
  end
end
