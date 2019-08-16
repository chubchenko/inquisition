RSpec.describe Inquisition::I18nTasks::Runner do
  let(:file_finder) { instance_double('I18n::Tasks::Scanners::Files::FileFinder', path: [File.join(Rails.root, )]) }

  before do
    # binding.pry
    # allow(::I18n::Tasks::Scanners::Files::FileFinder).to receive(:new).and_return(file_finder)
  end
  # include_examples 'runner', 'i18n_tasks.yml'
end
