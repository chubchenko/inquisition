RSpec.describe Inquisition::Core::Builders::Html::DatabaseSummaryPageBuilder do
  subject{ Inquisition::Core::Builders::Html::DatabaseSummaryPageBuilder }

  describe 'constants' do
    it 'have TEMPLATE constant' do
      expect(subject).to be_const_defined(:TEMPLATE)
    end

    it 'have PAGE_PRESENTER constant' do
      expect(subject).to be_const_defined(:PAGE_PRESENTER)
    end
  end
end
