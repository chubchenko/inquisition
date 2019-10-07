RSpec.describe Inquisition::Outputter::HTML::Builder do
  describe '.call' do
    let(:builder) { instance_double(described_class) }

    before do
      allow(builder).to receive(:call)
      allow(described_class).to receive(:new).and_return(builder)
      described_class.call([])
    end

    it { expect(builder).to have_received(:call) }
  end

  describe '#call' do
    let(:issue) do
      Inquisition::Issue.new(
        path: 'app/controllers/users_controller.rb',
        line: 42,
        severity: Inquisition::Severity::HIGH,
        message: 'Potentially dangerous key allowed for mass assignment',
        category: Inquisition::Category::SECURITY,
        runner: Inquisition::Brakeman::Runner.new
      )
    end

    before do
      allow(Launchy).to receive(:open)
    end

    it 'copies assets' do
      described_class.call([])

      ['application.css', 'application.js'].each do |filename|
        expect(File).to exist(File.join(Inquisition::Configuration.instance.output_path, 'assets', filename))
      end
    end

    it 'creates overview page' do
      described_class.call([issue])

      expect(File).to exist(File.join(Inquisition::Configuration.instance.output_path, 'overview.html'))
    end

    it 'creates issues page' do
      described_class.call([issue])

      expect(File).to exist(File.join(Inquisition::Configuration.instance.output_path, 'issues.html'))
    end
  end
end
