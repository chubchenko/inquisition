# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Builders::Html::PagesBuilder, type: :unit do
  include AuditorsHelpModule

  subject{ Inquisition::Core::Builders::Html::PagesBuilder }

  describe 'constants' do
    it 'have PAGE_BUILDERS constant' do
      expect(subject).to be_const_defined(:PAGE_BUILDERS)
    end
  end

  describe '#call' do
    before do
      stub_const("Inquisition::Core::Builders::Html::PagesBuilder::PAGE_BUILDERS", {
        index: FakePages::HtmlPageBuilder
      })
    end

    xit 'return builded pages with format' do
      expect(subject.new(auditors_tree)).to match_json_schema('pages_builder')
    end
  end
end
