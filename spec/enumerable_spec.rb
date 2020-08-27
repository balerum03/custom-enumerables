require '../main'

describe Enumerable do
  let(:my_array) { [1, 2, 3, 4] }
  let(:test_array1) { [1, 2, 3, 5, 5, 7, 2, 6, 7, 7, 0, 4, 4, 0, 2, 0, 6, 6, 8, 1, 6, 8, 6, 2, 3, 6, 1, 5, 2, 6, 7, 2, 5, 8, 2, 0, 7, 3, 2, 3, 6, 1, 2, 8, 3, 7, 0, 5, 0, 0, 2, 6, 1, 5, 2] }
  let(:test_array2) { %w[ant bear cat] }
  let(:test_array3) { [1, 1, nil] }
  let(:test_array4) { [nil, false, nil] }
  # my_each test cases
  describe '#my_each' do
    context 'A block is not given' do
      it 'Retunrns an enumerator' do
        expect(my_array.my_each).to be_a(Enumerable)
      end
    end

    context 'A block is given' do
      it 'Returns same result as in the original Ruby each method' do
        expect(my_array.my_each { |x| puts x }).to eql(my_array.each { |x| puts x })
      end
    end
  end
  # my_each_with_index test cases
  describe '#my_each_with_index' do
    context 'A block is not given' do
      it 'Returns an enumerator' do
        expect(my_array.my_each_with_index).to be_a(Enumerable)
      end
    end

    context 'A block is given' do
      it 'Returns the same result as the original Ruby method each_with_index' do
        expect(my_array.my_each_with_index { |x| puts x }).to eql(my_array.each { |x| puts x })
      end
    end
  end
  # my_select test cases.
  describe '#my_select' do
    context 'A block is not given' do
      it 'Retunrs an enumerator' do
        expect(test_array1.my_select).to be_a(Enumerable)
      end
    end

    context 'A block is given' do
      it 'returns the same result as the original Ruby method select' do
        expect(test_array1.my_select { |x| x > 3 }).to eql(test_array1.select { |x| x > 3 })
      end
    end

    context 'A block is given and the result is an array' do
      it 'returns an array with the elements that meet the condition' do
        expect(test_array1.my_select { |x| x > 3 }).to be_a(Array)
      end
    end
  end
  # my_all test cases
  describe '#my_all?' do
    context 'No block or parameter is given' do
      it 'only return true when none of the elements are false or nil' do
        expect(test_array4.my_all?).to equal(false)
      end
    end

    context 'A parameter is given' do
      it 'returns true when the elements on the collection match the pattern' do
        expect(test_array2.my_all?(/a/)).to equal(true)
      end
    end

    context 'A block is given and the condition is not met by all elements' do
      it 'only return false when the condition is not met in at least of the elements' do
        expect(test_array1.my_all? { |x| x > 2 }).to equal(false)
      end
    end

    context 'A block is given and the condition is met by all elements' do
      it 'only return true if the condition is met by all elements' do
        expect(test_array1.my_all? { |x| x < 10 }).to equal(true)
      end
    end

    context 'No block and no parameter, the array has a nil element on it' do
      it 'returns false when there is a nill or false element on the collection' do
        expect(test_array3.my_all?).to equal(false)
      end
    end
  end

  # my_any? test cases
  describe '#my_any?' do
    context 'No block or parameter is given' do
      it 'return false only when all element are false or nil' do
        expect(test_array3.my_any?).to equal(true)
      end
    end
  end

  context 'A parameter is given' do
    it 'returns true when at least on element meets the condition' do
      expect(test_array2.my_any?(/t/)).to equal(true)
    end
  end

  context 'A block is given' do
    it 'return false when none of the element meet the condition on the block' do
      expect(test_array1.my_any? { |x| x > 10 }).to equal(false)
    end
  end

  context 'A block is not given and all elements on the collection are false or nil' do
    it 'return false when all the elements on the collection are false or nil' do
      expect(test_array4.my_any?).to equal(false)
    end
  end

  # my_none? test cases
  describe '#my_none?' do
    context 'block is given and the condition is not met' do
      it 'returns true when none of the elements on the collection meet the condition' do
        expect(test_array1.my_none? { |x| x == 10 }).to equal(true)
      end
    end

    context 'parameter is given and it does not meet any of the element on the collection' do
      it 'returns true when condition is not met' do
        expect(test_array2.my_none?(/d/)).to equal(true)
      end
    end

    context 'block is not given an all elements are false or nil' do
      it 'returns true when all elements on collection are false or nil' do
        expect(test_array4.my_none?).to equal(true)
      end
    end

    context 'block is given and the condition is met' do
      it 'returns false when at least one of the elements meets the condition' do
        expect(test_array1.my_none? { |x| x == 1 }).to equal(false)
      end
    end
  end

  # my_count test cases
  describe '#my_count' do
    context 'no parameter or block given' do
      it 'returns the number of elements on the array' do
        expect(my_array.my_count).to eql(4)
      end
    end

    context 'block is given' do
      it 'returns the number of elements on the collection that meet the condition' do
        expect(test_array1.my_count { |x| x < 4 }).to eql(test_array1.count { |x| x < 4 })
      end
    end

    context 'parameter is given' do
      it 'returns the number of elements that are the same as the one given as parameter' do
        expect(test_array2.my_count('ant')).to eql(1)
      end
    end
  end

  # my_map test cases
  describe '#my_map' do
    context 'no block given' do
      it 'returns an enumerator' do
        expect(test_array1.my_map).to be_a(Enumerable)
      end
    end

    context 'block is given' do
      it 'returns a new array with the results of the operation being applied to the elements' do
        expect(my_array.my_map { |x| x * 2 }).to eql([2, 4, 6, 8])
      end
    end
  end

  # my_inject
  describe '#my_inject' do
    context 'symbol is given as parameter' do
      it 'returns the result of the operation symbol given as parameter being applied' do
        expect(test_array1.my_inject(:+)).to eql(test_array1.inject(:+))
      end
    end

    context 'no block is given and the parameter is not a valid symbol' do
      it 'return TypeError' do
        expect { my_array.my_inject(13) }.to raise_error(TypeError)
      end
    end

    context 'two parameters are given and they are valid' do
      it 'the collection of element with the operation that the symbol represents and the number given' do
        expect(my_array.my_inject(2, :*)).to equal(my_array.inject(2, :*))
      end
    end

    context 'parameter and block given' do
      it 'yields to the block given using the given parameter' do
        expect(my_array.my_inject(10, :+)).to equal(my_array.inject(10, :+))
      end
    end

    context 'only block is given' do
      it 'yields using the block given' do
        expect(my_array.my_inject { |x, y| y * x }).to equal(my_array.inject { |x, y| y * x })
      end
    end
  end
end
