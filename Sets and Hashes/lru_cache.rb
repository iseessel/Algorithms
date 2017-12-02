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
    node = @map[key]
    if node
      update_node!(node)
    else
      eject! if count >= @max
      calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    node = @store.append(key, val)
    @map[key] = node
    val
  end

  def update_node!(node)
    @map[node.key] = @store.append(node.key, node.val)
    node.remove
    node.val
  end

  def eject!
    last_node = @store.first
    last_node.remove
    @map[last_node.key] = nil
  end
end
