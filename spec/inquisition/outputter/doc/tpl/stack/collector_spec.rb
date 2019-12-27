RSpec.describe Inquisition::Outputter::Doc::TPL::Stack::Collector do
  describe '#call' do
    subject(:collector) { described_class.new(%w[rails puma]) }

    it do
      expect(collector.call(type: :gem)).to contain_exactly(
        OpenStruct.new(name: 'rails', homepage: 'http://rubyonrails.org', type: :gem),
        OpenStruct.new(name: 'puma', homepage: 'http://puma.io', type: :gem)
      )
    end
  end
end
