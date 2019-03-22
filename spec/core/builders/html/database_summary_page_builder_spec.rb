# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Builders::Html::DatabaseSummaryPageBuilder do
  subject{ Inquisition::Core::Builders::Html::DatabaseSummaryPageBuilder }

  describe 'constants' do
    it 'have TEMPLATE_PATH constant' do
      expect(subject).to be_const_defined(:TEMPLATE_PATH)
    end

    it 'have PAGE_PRESENTER constant' do
      expect(subject).to be_const_defined(:PAGE_PRESENTER)
    end
  end
end
