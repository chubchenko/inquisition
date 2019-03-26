# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Builders::BaseHtmlBuilder do
  include AuditorsHelpModule

  subject{ Inquisition::Core::Builders::BaseHtmlBuilder.new(auditors_tree) }

  describe 'constants' do
    it 'have BASE_ENGINE constant' do
      expect(subject.class).to be_const_defined(:BASE_ENGINE)
    end
  end

  describe '#call' do

    before do
      allow(subject).to receive(:template) { FakePages::HtmlPageBuilder::TEMPLATE_PATH }
      allow(subject).to receive(:presenter) { page_presenter }
    end

   let(:page_presenter) { FakePages::HtmlPagePresenter.new }

    it 'build page by template' do
      expect(subject.call(:page)).to eq("<p>#{page_presenter.rendered_text}</p>\n")
    end
  end
end
