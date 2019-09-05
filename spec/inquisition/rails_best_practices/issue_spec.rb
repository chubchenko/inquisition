RSpec.describe Inquisition::RailsBestPractices::Issue do
  describe '#to_h' do
    subject(:issue) { described_class.new(error) }

    let(:message) { 'not use time_ago_in_words' }
    let(:path) { 'app/views/layouts/application.html.erb' }
    let(:line) { 13 }

    let(:error) do
      instance_double(
        RailsBestPractices::Core::Error,
        short_filename: path,
        line_number: line,
        message: message,
        type: 'RailsBestPractices::Reviews::NotUseTimeAgoInWordsReview'
      )
    end

    let(:options) { { category: :style, severity: :low, message: message, path: path, line: line.to_i } }

    it { expect(issue.to_h).to include(options) }
  end
end
