require 'spec_helper'

RSpec.describe Inquisition::Core::Outputers::HtmlOutputer do
  include AuditorsHelpModule

  subject{ Inquisition::Core::Outputers::HtmlOutputer.new }

  describe 'constants' do
    %i[REPORT_FOLDER_NAME INDEX_PAGE ASSETS_PATH BASE_ENGINE].each do |constant_name|
      it "have #{constant_name} constant" do
        expect(subject.class).to be_const_defined(constant_name)
      end
    end
  end

  describe '#call' do

    before do
      stub_const("Inquisition::Core::Outputers::HtmlOutputer::REPORT_FOLDER_NAME", report_path)
      allow(Time).to receive_message_chain(:now, :to_i, :to_s){ time }
      allow(subject).to receive(:open_front_page)
      allow(subject).to receive(:build_pages)
      allow(subject).to receive(:save_pages)
    end

    after do
      FileUtils.rm_rf(File.join(Dir.pwd, report_path))
    end

    let(:report_path) { 'spec/inquisition/tmp/inquisition' }
    let(:time) { '11111111' }

    it 'create folder' do
      subject.call
      expect(File.directory?(File.join(Dir.pwd, report_path, time))).to be_truthy
    end

    it 'copy assets' do
      subject.call
      subject.class::ASSETS_PATH.each do |path|
        is_directory = File.directory?(File.join(Dir.pwd, report_path, time, File.basename(path)))
        expect(is_directory).to be_truthy
      end
    end
  end
end
