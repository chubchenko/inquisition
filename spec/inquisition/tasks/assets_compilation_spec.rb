RSpec.describe 'rake assets_compilation', type: :task do
  it 'preloads the Rails environment' do
    expect(task.prerequisites).to include('environment')
  end

  context 'when task invokes' do
    let(:sprockets) { instance_double(Sprockets::Environment) }
    let(:asset) { instance_double(Sprockets::Asset) }

    before do
      allow(Sprockets::Environment).to receive(:new).and_return(sprockets)
      allow(sprockets).to receive(:append_path)
      allow(sprockets).to receive(:find_asset).and_return(asset)
      allow(asset).to receive(:write_to)
    end

    it do
      task.execute
      expect(Sprockets::Environment).to have_received(:new).with(Inquisition.root).once
      expect(sprockets).to have_received(:append_path).twice
      expect(sprockets).to have_received(:find_asset).twice
      expect(asset).to have_received(:write_to).twice
    end
  end
end
