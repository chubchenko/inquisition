RSpec.describe Inquisition::Outputter::Doc::Templates::Home do
  subject(:home) { described_class.new }

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
