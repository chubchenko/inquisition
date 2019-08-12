require 'rake'

RSpec.shared_context 'rake' do
  subject(:task) { Rake::Task[task_name] }

  let(:task_name) { self.class.top_level_description }
  let(:task_path) { "lib/inquisition/tasks/#{task_name.split(':')[0]}" }

  before do
    Rake.application.rake_require(task_path, [Inquisition.root])
    Rake::Task.define_task(:environment)
  end
end
