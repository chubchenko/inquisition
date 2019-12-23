RSpec.describe Inquisition::Outputter::Xlsx::Gem do
  subject(:gem) { described_class.new(spec, dependency) }

  let(:spec) { OpenStruct.new(name: 'puma',homepage: 'http://puma.io') }
  let(:dependency) { instance_double(Bundler::Dependency, groups: [:default]) }

  describe '#to_a' do
    before do
      gem.version = Inquisition::Outputter::Xlsx::Version.new(
        '3.4.1',
        '4.0.1'
      )
    end

    it do
      expect(gem.to_a).to match_array(
        ['puma', 'http://puma.io', '3.4.1', '4.0.1', true, [:default], nil]
      )
    end
  end

  describe '#name' do
    it { expect(gem.name).to eq('puma') }
  end

  describe '#homepage' do
    it { expect(gem.homepage).to eq('http://puma.io') }
  end

  describe '#env' do
    it { expect(gem.env).to eq([:default]) }
  end

  describe '#status' do
    it { expect(gem.status).to be nil }
  end
end
