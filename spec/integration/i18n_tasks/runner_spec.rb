RSpec.describe Inquisition::I18nTasks::Runner do
  # before do
  #   allow(Dir).to receive(:pwd).and_return(File.join(Dir.pwd, 'spec/dummy'))
  # end
  include_examples 'runner', 'i18n_tasks.yml'
end
