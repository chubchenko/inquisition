RSpec.shared_examples 'present file' do |params|

  params.each do |file, type|
    it "file #{type} presented" do
      expect(File).to exist(file)
    end
  end
end
