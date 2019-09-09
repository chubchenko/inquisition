RSpec.describe Inquisition::Bundler::Leak::Issue do
  describe '#to_h' do
    subject(:issue) { described_class.new(advisory) }

    let(:advisory) { instance_double(Bundler::Plumber::Advisory, title: 'Memory leak in formatter middleware') }
    let(:options) { { severity: :low, message: advisory.title, path: 'Gemfile.lock', line: nil } }

    it { expect(issue.to_h).to include(options) }
  end
end
