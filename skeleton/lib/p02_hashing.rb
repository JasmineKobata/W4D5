class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    h = 0
    self.each do |elem|
      h += (elem.hash + h) % 100
    end
    h
  end
end

class String
  def hash
    h = 0
    self.each_char do |char|
      h += (char.ord.hash + h) % 100
    end
    h
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    h = 0
    self.each do |elem|
      h += elem.hash
    end
    h
  end
end
