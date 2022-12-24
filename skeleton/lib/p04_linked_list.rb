class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

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
    @next = nil
    @prev = nil
    self
  end
end

class LinkedList
include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
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

  def get_node(key)
    it_node = @head
    while it_node != @tail
      return it_node if it_node.key == key
      it_node = it_node.next
    end
    nil
  end

  def get(key)
    node = get_node(key)
    node.val if node
  end

  def include?(key)
    node = get_node(key)
    if node == nil then false else true end
  end

  def append(key, val)
    new_node = Node.new(key, val)
    @tail.prev.next = new_node
    new_node.prev = @tail.prev
    new_node.next = @tail
    @tail.prev = new_node
    new_node
  end

  def update(key, val)
    node = get_node(key)
    node.val = val if node
  end

  def remove(key)
    node = get_node(key)
    node.remove if node
  end

  def each
    node_vals = []
    it_node = first
    while it_node != @tail
      yield it_node
      it_node = it_node.next
    end
    p node_vals
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
