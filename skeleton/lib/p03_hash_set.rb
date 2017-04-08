require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    hash_f = key.hash
    resize! if num_buckets == @count
    self[hash_f] << key
    @count+=1
  end

  def include?(key)
    hash_f = key.hash
    self[hash_f].any? {|el| el == key }
  end

  def remove(key)
    hash_f = key.hash
    self[hash_f].delete(key)
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
      bucket.each { |el| temp[ el.hash % temp.length]  << el }
    end
    @store = temp
  end
end
