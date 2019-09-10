require 'rake'

module TaskExampleGroup
  extend ActiveSupport::Concern

  included do
    subject(:task) { tasks[task_name] }

    let(:task_name) { self.class.top_level_description.sub(/\Arake /, '') }
    let(:tasks) { Rake::Task }
  end
end

RSpec.configure do |config|
  config.include(TaskExampleGroup, type: :task)

  config.before(:suite) do
    Rails.application.load_tasks
  end
end
