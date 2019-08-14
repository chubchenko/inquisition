RSpec.describe Inquisition::Formatters::HtmlFormatter do
  describe '#call' do
    let(:issue) { instance_double(Inquisition::Issue) }
    let(:formatter) { described_class.new([issue]) }

    let(:html_files_directory) { "#{Rails.root}/inquisition_report" }
    let(:issues_html) { 'issues_list.html' }
    let(:overview_html) { 'overview.html' }
    let(:assets_keep) { 'assets/.keep' }

    before { allow(issue).to receive(:message) }

    after { FileUtils.rm_r(html_files_directory) }

    it do
      formatter.call
      expect(File).to exist("#{html_files_directory}/#{issues_html}")
      expect(File).to exist("#{html_files_directory}/#{overview_html}")
      expect(File).to exist("#{html_files_directory}/#{assets_keep}")
    end
  end
end
