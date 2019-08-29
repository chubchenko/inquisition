RSpec.describe Inquisition::FactoryBot::Runner do
  include_examples 'runner', 'factory_bot.yml' do
    before { FactoryBot.definition_file_paths = [File.join(Rails.root, 'spec', 'factories')] }
  end
end
