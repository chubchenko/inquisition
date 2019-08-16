RSpec.describe Inquisition::Formatters::HtmlFormatter do
  describe '#call' do
    let(:issue) { instance_double(Inquisition::Issue) }
    let(:formatter) { described_class.new([issue]) }
    let(:report_directory) { "#{Rails.root}/inquisition_report" }
    let(:report_content) { ['issues_list.html', 'overview.html', 'assets/.keep'] }

    before { allow(File).to receive(:read).and_return('') }

    after { FileUtils.rm_r(report_directory) }

    it do
      formatter.call
      report_content.each { |file| expect(File).to exist("#{report_directory}/#{file}") }
    end
  end
end
