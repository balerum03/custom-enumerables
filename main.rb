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


