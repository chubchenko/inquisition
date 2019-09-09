RSpec.describe Inquisition::RailsBestPractices::Warning do
  describe '#to_h' do
    subject(:warning) { described_class.new(error) }

    let(:error) do
      instance_double(RailsBestPractices::Core::Error,
                      short_filename: 'config/initializers/backtrace_silencers.rb',
                      line_number: '6',
                      message: 'line is longer than 111 characters (112 characters)',
                      type: 'RailsBestPractices::Reviews::NotUseTimeAgoInWordsReview')
    end
    let(:options) do
      {
        path: 'config/initializers/backtrace_silencers.rb',
        line: 6,
        severity: Inquisition::Severity::LOW,
        message: 'Line is longer than 111 characters (112 characters)',
        category: Inquisition::Category::STYLE
      }
    end

    it { expect(warning.to_h).to include(options) }
  end
end
