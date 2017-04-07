class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) {false}
  end

  def insert(num)
    raise "Out of bounds" unless num.between?(0, @max-1)
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" unless num.between?(0, @max-1)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

#   def is_valid?(num)
#     if num.is_a?(String) && num =~ /\A\d+\z/
#   end
#
#   def validate!(num)
#     if num.is_a?(String) && num =~ /\A\d+\z/
#       num.to_i
#     else
#       false
#     end
#   end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].any? {|el| el == num }
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if num_buckets == @count
    self[num] << num
    @count+=1
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].any? {|el| el == num }
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = Array.new(num_buckets * 2) {Array.new}
    @store.each do |bucket|
      bucket.each { |el| temp[ el % temp.length]  << el }
    end
    @store = temp
  end
end
