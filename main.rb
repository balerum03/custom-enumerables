# ruby project.
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
    elsif args.nil? && !block_given?
      my_each { |i| return !i.nil? || i != false ? true : false }
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
end
