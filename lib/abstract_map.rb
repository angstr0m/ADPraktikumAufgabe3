require './assoc'
require './Extensions_OO_V1'

class AbstractMap
  def initialize(default)
    @default = default
  end
  
  def empty?
    raise "abstractMethodError"
  end
  
  def fetch(key, &block)
    raise "abstractMethodError"
  end
  
  def [](key)
    raise "abstractMethodError"
  end
  
  def []=(key, value)
    raise "abstractMethodError"
  end
  
  def each(&block)
    raise "abstractMethodError"
  end
  
  # Clone wird von Object übernommen!
  
  def sort
    raise "abstractMethodError"
  end
  
  def to_sorted_a
    raise "abstractMethodError"
  end
  
  def ==(other)
    raise "abstractMethodError"
  end
  
  def eql?
    raise "abstractMethodError"
  end
  
  def hash
    raise "abstractMethodError"
  end
  
  def includes_key?
    raise "abstractMethodError"
  end
  
  def includes_value?
    raise "abstractMethodError"
  end
  
  def size
    raise "abstractMethodError"
  end
end
