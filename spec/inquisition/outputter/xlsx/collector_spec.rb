RSpec.describe Inquisition::Outputter::Xlsx::Collector do
  let(:collector) { described_class.new }

  describe '#call' do
    let(:gem) do
      Inquisition::Outputter::Xlsx::Gem.new(
        OpenStruct.new(
          name: 'inquisition',
          homepage: 'https://rubygarage.org'
        ),
        OpenStruct.new(
          groups: [:default]
        )
      )
    end

    it do
      gem.version = Inquisition::Outputter::Xlsx::Version.new('0.2.0', '0.2.0')

      expect(collector.call).to include(
        gem
      )
    end
  end
end
