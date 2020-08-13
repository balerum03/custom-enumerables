require "../main"


describe Enumerable do
  let (:my_array) {[1, 2, 3, 4]}
  describe '#my_each' do
    context "No block given" do
      it "should return an enumerable" do
        expect(my_array.my_each).to be_a(Enumerable)
      end
    end
  end
end

