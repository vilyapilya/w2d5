class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new(:head)
    @tail = Link.new(:tail)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = find_node(key)
    node.nil? ? nil : node.val
  end

  def include?(key)
    find_node(key) ? true : false
  end

  def append(key, val)
    node = Link.new(key, val)
    node.next = @tail
    @tail.prev.next = node
    node.prev = @tail.prev
    @tail.prev = node
  end

  def update(key, new_val)
    node = find_node(key)
    node.val = new_val unless node.nil?
  end

  def remove(key)
    node = find_node(key)
    raise "no such key exists" if node.nil?
    node.remove
  end

  def each(&prc)
    node = @head.next
    until node==@tail
      prc.call(node)
      node = node.next
    end
  end

  private

  def find_node(key)
    node = @head
    until node.key == key || node == @tail
      node = node.next
    end
    node.key == key ? node : nil
  end
  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
