RSpec.describe Inquisition::Errors::BaseConfigAbsenseError do
  subject { Inquisition::Errors::BaseConfigAbsenseError.new }

  it 'return error message' do
    expect(subject.message).to eq('Run inquisition build first')
  end
end
