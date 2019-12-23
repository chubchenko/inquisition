RSpec.describe Inquisition::Outputter::Doc::TPL::Home do
  subject(:home) { described_class.new }

  describe '#produce' do
    it { expect(home.produce).to be_an_instance_of(Binding) }
  end

  describe '#name' do
    it { expect(home.name).to eq('DUMMY') }
  end

  describe '#date' do
    around do |example|
      Timecop.freeze(Time.local(2019, 12, 12))
      example.run
      Timecop.return
    end

    it { expect(home.date).to eq('12th December 2019') }
  end
end
