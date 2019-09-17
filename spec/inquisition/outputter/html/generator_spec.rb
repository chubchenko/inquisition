RSpec.describe Inquisition::Outputter::HTML::Generator do
  describe '#call' do
    let(:runner) { Inquisition::Runner.new }
    let(:issue) do
      instance_double(
        Inquisition::Issue,
        path: 'app/controllers/application_controller.rb',
        line: 5,
        severity: Inquisition::Severity::LOW,
        category: instance_double(Inquisition::Category, name: :security),
        message: "ApplicationController#test_fasterer doesn't depend on instance state (maybe move it to another class?)",
        runner: runner
      )
    end
    let(:formatter) { described_class.new([issue]) }
    let(:report_directory) { File.join(Rails.root, 'inquisition') }
    let(:compiled_assets_directory) { File.join(Rails.root, 'public', 'inquisition', 'precompiled') }
    let(:report_content) { ['issues_list.html', 'overview.html'] }
    let(:compiled_assets) { ['application.js', 'application.css'] }

    after do
      FileUtils.rm_r(report_directory)
      FileUtils.rm_r(File.join(Rails.root, 'public', 'inquisition'))
    end

    it 'generates report with necessary files' do
      formatter.call
      report_content.each { |file| expect(File).to exist("#{report_directory}/#{file}") }
      compiled_assets.each { |file| expect(File).to exist("#{compiled_assets_directory}/#{file}") }
    end
  end
end
