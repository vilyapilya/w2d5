require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    val = @map[key]
    #if key doesn't exist
    if val.nil?
      if self.count == @max
        eject!
      end
      calc!(key)
    #if key already exists
    else
      update_link!(key)
    end
    @map[key].val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    @store.append(key, val)
    @map[key] = @store.last
  end

  def update_link!(key)
    # suggested helper method; move a link to the end of the list
    val = @map[key].val
    @store.remove(key)
    @store.append(key, val)
    @map[key] = @store.last
  end

  def eject!
    first_key = @store.first.key
    @store.remove(first_key)
    @map.delete(first_key)
  end
end
