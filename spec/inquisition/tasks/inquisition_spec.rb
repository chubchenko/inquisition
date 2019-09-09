RSpec.describe 'rake inquisition', type: :task do
  before { allow(Inquisition::Collector).to receive(:invoke) }

  it 'preloads the Rails environment' do
    expect(task.prerequisites).to include('environment')
  end

  it do
    task.invoke

    expect(Inquisition::Collector).to have_received(:invoke).once
  end
end
