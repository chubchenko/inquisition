RSpec.describe Inquisition::Formatters::HtmlFormatter do
  describe '#call' do
    let(:runner) { Inquisition::Runner.new }
    let(:issue) { instance_double(Inquisition::Issue, path: '', line: '', severity: :low, message: '', runner: runner) }
    let(:formatter) { described_class.new([issue]) }
    let(:report_directory) { File.join(Rails.root, 'inquisition') }
    let(:report_content) { ['issues_list.html', 'overview.html'] }

    after { FileUtils.rm_r(report_directory) }

    it do
      formatter.call
      report_content.each { |file| expect(File).to exist("#{report_directory}/#{file}") }
    end
  end
end
