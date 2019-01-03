RSpec.shared_examples 'call callable objects' do |objects|

  objects.each do |object, type|
    it "call #{type} object" do
      expect(object).to receive(:call)
      subject
    end
  end
end
