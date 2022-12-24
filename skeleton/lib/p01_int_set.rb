class MaxIntSet
  attr_reader :store

  def initialize(max)
    @max = max
    @store = Array.new(@max, false)

  end

  def insert(num)
    if is_valid?(num)
      p num
      @store[num] = true
    else
      raise ArgumentError.new("Out of bounds")
    end
  end

  def remove(num)
    if is_valid?(num)
      @store[num] = false
    else
      raise ArgumentError.new("Out of bounds")
    end
  end

  def include?(num)
    if is_valid?(num)
      @store[num] == true
    else
      raise ArgumentError.new("Out of bounds")
    end
  end

  private

  def is_valid?(num)
    num < @max && num >= 0
  end

  def validate!(num)

  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num if !include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
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
    if !include?(num)
      self[num] << num 
      @count += 1
    end
    resize! if @count > num_buckets
  end

  def remove(num)
    @count -= 1 if self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2) { Array.new }
    @store.flatten.each do |elem|
      new_store[elem] << elem
    end
    @store = new_store
  end
end
