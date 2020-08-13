require "../main"


describe Enumerable do
  let (:my_array) {[1, 2, 3, 4]}
  # let(:test_case) {}
  describe '#my_each' do
    #negative test
    context "No block given" do
      it "should return an enumerable" do
        expect(my_array.my_each).to be_a(Enumerable)
      end
    end
    #positive test
    context "block given" do
      it "should match result for original #each method" do
        expect(my_array.my_each{|e| puts e}).to eq(my_array.each{|e| puts e})
      end
    end
  end
  describe '#my_each_with_index' do
  #negative test
  context "No block given" do
    it "should return an enumerable" do
      expect(my_array.my_each_with_index).to be_a(Enumerable)
    end
  end
  #positive test
  context "block given" do
    it "should match result for original #each_with_index method" do
      expect(my_array.my_each_with_index{|e, i| puts e * i}).to eq(my_array.each_with_index{|e, i| puts e * i})
    end
  end
end
end

