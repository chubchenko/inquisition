RSpec.describe Inquisition::Formatters::HtmlFormatter do
  describe '#call' do
    let(:issue) { instance_double(Inquisition::Issue) }
    let(:formatter) { described_class.new([issue]) }

    let(:report_directory) { "#{Rails.root}/inquisition_report" }
    let(:issues_html) { 'issues_list.html' }
    let(:overview_html) { 'overview.html' }
    let(:assets_keep) { 'assets/.keep' }
    let(:report_content) { [issues_html, overview_html, assets_keep] }

    before do
      allow(issue).to receive(:message)
      allow(issue).to receive(:path)
      allow(issue).to receive(:line)
    end

    after { FileUtils.rm_r(report_directory) }

    it do
      formatter.call
      report_content.each { |file| expect(File).to exist("#{report_directory}/#{file}") }
    end
  end
end
