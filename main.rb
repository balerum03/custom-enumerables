# ruby project.
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    size.times { |i| yield(to_a[i]) }
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    size.times do |i|
      yield to_a[i], i
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_array = []
    my_each { |i| new_array << i if yield i }
    new_array
  end

  def my_all?(args = nil)
    if !args.nil? && !args.is_a?(Class)
      if args.is_a?(Regexp)
        my_each { |i| return false unless !i[args].nil? || i[args] == 1 }
      else
        my_each { |i| return false unless i == args }
      end
    elsif args.is_a?(Class)
      my_each { |i| return false unless i.is_a?(args) }
    elsif args.nil? && block_given?
      my_each { |i| return false unless yield i }
    else
      my_each { |i| return false if i.nil? || i == false }
    end
    true
  end

  def my_any?(args = nil)
    if size == 1
      return false if self[0].nil? || self[0] == empty? || self[0] == false
    elsif args.is_a?(Regexp)
      my_each { |i| return true if !i[args].nil? || i[args] == 1 }
    elsif args.nil? && !block_given?
      my_each { |i| return true if !i.nil? && i != false }
    elsif !args.is_a?(Class) && !block_given?
      my_each { |i| return true if i == args }
    elsif args.is_a?(Class)
      my_each { |i| return true if i.is_a?(args) }
    elsif block_given?
      my_each { |i| return true if yield i }
    end
    false
  end

  def my_none?(args = nil)
    return true if self == [] || nil?

    if !block_given? && args.nil?
      my_each { |i| return false if !i.nil? && i != false }
    elsif args.is_a?(Regexp)
      my_each { |i| return false if i.to_s =~ args }
    elsif args.is_a?(Class)
      my_each { |i| return false if i.is_a?(args) }
    elsif !args.is_a?(Class) && !block_given?
      my_each { |i| return false if i == args }
    elsif block_given?
      my_each { |i| return false if yield i }
    end
    true
  end

  def my_count(args = nil)
    return 0 if args.is_a?(Class)

    count = 0
    my_each do |i|
      if !block_given?
        count += 1 if args.nil? || i == args
      elsif yield i
        count += 1
      end
    end
    count
  end

  def my_map(args = nil)
    return to_enum(:my_map) if args.nil? && !block_given?

    new_array = []
    if args.nil?
      my_each_with_index { |i, j| new_array[j] = yield i }
    else
      my_each_with_index { |i, j| new_array[j] = args.call(i) }
    end
    new_array
  end

  def my_inject(arg1 = nil, arg2 = nil)
    raise LocalJumpError, 'No block Given or Empty Argument' if arg1.nil? && arg2.nil? && !block_given?

    memo = nil
    symbol = nil
    if !arg1.nil? && !arg2.nil?
      memo = arg1
      symbol = arg2
      my_each do |i|
        memo = memo.send(symbol, i)
      end
    elsif arg1.is_a? Symbol
      symbol = arg1
      my_each { |i| memo = (memo ? memo.send(symbol, i) : i) }
    else
      memo = arg1
      my_each { |i| memo = (memo ? yield(memo, i) : i) }
    end
    memo
  end
end

def multiply_els(arg = nil)
  raise TypeError, 'No Array Given' if arg.nil? || !arg.is_a?(Array)

  arg.my_inject(:*)
end

test_array2 = %w[a b c d]
test_array1 = [11, 5, 3, 56]

# p test_array2.my_select { |x| x == 'c' }

# p test_array2.select { |x| x == 'c' }

# p test_array1.all?(/t/)

# p %w[andt dbear cdat].my_all?(/d/) #=> false

p test_array1.all?(3) { |i| i > 2 }
