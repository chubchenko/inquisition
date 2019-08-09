require 'rake'

RSpec.describe ':inquisition' do
  let(:collector) { instance_double(Inquisition::Collector) }

  before do
    Rake.application.rake_require 'inquisition/tasks/inquisition'
    Rake::Task.define_task(:environment)
    allow(Inquisition::Collector).to receive(:new) { collector }
    allow(collector).to receive(:call)
  end

  it do
    Rake.application.invoke_task 'inquisition'
    expect(Inquisition::Collector).to have_received(:new).exactly(1).times
    expect(collector).to have_received(:call).exactly(1).times
  end
end
