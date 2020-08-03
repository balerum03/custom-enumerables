#ruby project.
module Enumerable
  def my_each
    return to_enum(__method__) unless block_given?

    size.times { |i| yield(to_a[i]) }
    self
  end

  def my_each_with_index
    return to_enum(__method__) unless block_given?

    size.times do |i|
      yield to_a[i], i
    end
    self
  end
end

number_array = [1,2,3,4,5,56]
string_array = ['h', 'o', 'l', 'a']

new_array_test = []
new_array_test = string_array.my_each{|x| p x}
p new_array_test
