class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 1
    self.each_with_index {|el, i| sum+=el.hash * (i + 1)}
    sum
  end
end

class String
  def hash
    sum = 0
    self.each_byte.with_index do |byte, i|
      sum = sum + ((byte.to_s.to_i(2) ^ 5) * (i + 1))
    end
    sum.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end

#[el ^ (n)].to_i(2)]*i.hash
