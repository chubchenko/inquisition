RSpec.describe Inquisition::I18nTasks::Runner do
  include_examples 'runner', 'i18n_tasks.yml' do
    before do
      allow(YAML).to receive(:load_file).and_return(
        data: { read: [Rails.root.to_s + '/config/locales/%{locale}.yml'] },
        search: { paths: [Rails.root.to_s + '/app'] }
      )
    end
  end
end
