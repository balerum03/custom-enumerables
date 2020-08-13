require '../main'

describe Enumerable do
  let(:my_array) { [1, 2, 3, 4] }
  let(:test_array1) { [1, 2, 3, 5, 1, 7, 3, 4, 5, 7, 2, 3, 2, 0, 8, 8, 7, 8, 8, 6, 2, 3, 6, 1, 5, 2, 6, 7, 2, 5, 8, 2, 0] }
  let(:test_array2) { %w[ant bear cat] }
  let(:test_array3) { [1, 1, 1] }
  let(:test_array4) { [1, 1, nil] }
  let(:test_array5) { [nil, false, nil] }

  describe '#my_each' do
    # negative test
    context 'No block given' do
      it 'should return an enumerable' do
        expect(my_array.my_each).to be_a(Enumerable)
      end
    end
    # positive test
    context 'block given' do
      it 'should match result for original #each method' do
        expect(my_array.my_each { |e| puts e }).to eq(my_array.each { |e| puts e })
      end
    end
  end

  describe '#my_each_with_index' do
    # negative test
    context 'No block given' do
      it 'should return an enumerable' do
        expect(my_array.my_each_with_index).to be_a(Enumerable)
      end
    end
    # positive test
    context 'block given' do
      it 'should match result for original #each_with_index method' do
        expect(my_array.my_each_with_index { |e, i| puts e * i }).to eq(my_array.each_with_index { |e, i| puts e * i })
      end
    end
  end

  describe '#my_select' do
    # negative_test
    context 'No block given' do
      it 'should return an enumerable' do
        expect(my_array.my_select).to be_a(Enumerable)
      end
    end
    # positive_test
    context 'When block is given' do
      it 'Return the specified value for which the block is true' do
        expect(my_array.my_select { |i| i < 3 }).to eql(my_array.select { |i| i < 3 })
      end
    end
  end

  describe '#my_all?' do
    context 'If no argument is given' do
      context 'no block is given' do
        it 'returns true if all the elements are not Nil or false' do
          expect(test_array1.my_all?).to equal(true)
        end

        it 'returns false if any of the elements are  Nil or false' do
          expect(test_array4.my_all?).to equal(false)
        end
      end
      context 'if block is given' do
        it 'returns true if all the elements satisfy the block' do
          expect(test_array2.my_all? { |word| word.length >= 3 }).to equal(true)
        end
      end
    end

    context 'If argument is given' do
      context 'If the argument is a class' do
        it 'returns true if all elements are members of the argument' do
          expect(test_array1.my_all?(Integer)).to equal(true)
        end

        it 'returns false if any elements are not members of the argument' do
          expect(test_array1.my_all?(String)).to equal(false)
        end
      end

      context 'If the argument is a regular expression' do
        it 'Returns true if all the elements match the argument' do
          expect(test_array2.my_all?(/a/)).to equal(true)
        end

        it 'Returns false if all the elements dont match the argument' do
          expect(test_array2.my_all?(/d/)).to equal(false)
        end
      end

      context 'If the argument is neither a Class or a Regex' do
        it 'returns true if all the elements are equal to the argument ' do
          expect(test_array3.my_all?(1)).to equal(true)
        end

        it 'returns false if all the elements are not equal to the argument ' do
          expect(test_array1.my_all?(1)).to equal(false)
        end
      end
    end
  end

  describe '#my_any?' do
    context 'If no argument is given' do
      context 'no block is given' do
        it 'returns true if any the elements are not Nil or false' do
          expect(test_array1.my_any?).to equal(true)
        end

        it 'returns false if all of the elements are  Nil or false' do
          expect(test_array5.my_any?).to equal(false)
        end
      end
      context 'if block is given' do
        it 'returns true if any the elements satisfy the block' do
          expect(test_array2.my_any? { |word| word.length == 4 }).to equal(true)
        end
      end
    end

    context 'If argument is given' do
      context 'If the argument is a class' do
        it 'returns true if any elements are members of the argument' do
          expect(test_array4.my_any?(Integer)).to equal(true)
        end

        it 'returns false if all elements are not members members of the argument' do
          expect(test_array1.my_any?(String)).to equal(false)
        end
      end

      context 'If the argument is a regular expression' do
        it 'Returns true if any the elements match the argument' do
          expect(test_array2.my_any?(/r/)).to equal(true)
        end
      end

      it 'Returns false if all the elements dont match the argument' do
        expect(test_array2.my_any?(/d/)).to equal(false)
      end
    end

    context 'If the argument is neither a Class or a Regex' do
      it 'returns true if any of the elements are equal to the argument ' do
        expect(test_array1.my_any?(1)).to equal(true)
      end

      it 'returns false if all the elements are not equal to the argument ' do
        expect(test_array1.my_all?(1)).to equal(false)
      end
    end
  end

  describe '#my_none?' do
    context 'If no argument is given' do
      context 'no block is given' do
        it 'returns true if all of the elements are Nil or false' do
          expect(test_array5.my_none?).to equal(true)
        end

        it 'returns false if any of the elements are not Nil or false' do
          expect(test_array4.my_none?).to equal(false)
        end
      end
      context 'if block is given' do
        it 'returns true if none the elements satisfy the block' do
          expect(test_array2.my_none? { |word| word.length == 5 }).to equal(true)
        end
      end
    end

    context 'If argument is given' do
      context 'If the argument is a class' do
        it 'returns true if none elements are members of the argument' do
          expect(test_array4.my_none?(String)).to equal(true)
        end

        it 'returns false if any elements are members of the argument' do
          expect(test_array1.my_none?(Integer)).to equal(false)
        end
      end

      context 'If the argument is a regular expression' do
        it 'Returns true if none of the elements match the argument' do
          expect(test_array2.my_none?(/z/)).to equal(true)
        end
      end

      it 'Returns false if any of the elements match the argument' do
        expect(test_array2.my_none?(/n/)).to equal(false)
      end
    end

    context 'If the argument is neither a Class or a Regex' do
      it 'returns true if none of the elements are equal to the argument ' do
        expect(test_array1.my_none?(10)).to equal(true)
      end

      it 'returns false if any of the elements are equal to the argument ' do
        expect(test_array1.my_none?(1)).to equal(false)
      end
    end
  end
end
