RSpec.describe Inquisition::Error::BaseConfigAbsenseError do
  subject { Inquisition::Error::BaseConfigAbsenseError.new }

  it 'return error message' do
    expect(subject.message).to eq('Run inquisition build first')
  end
end
