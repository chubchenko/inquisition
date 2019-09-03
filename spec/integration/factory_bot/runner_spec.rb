RSpec.describe Inquisition::FactoryBot::Runner do
  include_examples 'runner', 'factory_bot.yml' do
    before do
      FactoryBot.definition_file_paths = [File.join(Rails.root, 'spec', 'factories')]
      FactoryBot.find_definitions
    end
  end
end
