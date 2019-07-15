RSpec.describe Inquisition::Core::BaseOutputer, type: :unit do
  include AuditorsHelpModule

  subject { Inquisition::Core::BaseOutputer.new }

  describe '.call' do
    it 'raise NotImplementedError' do
      expect { subject.call }.to raise_error(NotImplementedError)
    end
  end
end