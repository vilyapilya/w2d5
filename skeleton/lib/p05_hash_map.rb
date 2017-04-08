require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count == @store.length
    list = bucket(key)
    if self.include?(key)
      list.update(key, val)
    else
      list.append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |list|
      list.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    len = @store.length
    temp = Array.new(len * 2) {LinkedList.new}
    self.each do |k, v|
      ind = k.hash % (len * 2)
      temp[ind].append(k, v)
    end
    @store = temp
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    hash_f = key.hash
    ind = hash_f % @store.length
    @store[ind]
  end
end
