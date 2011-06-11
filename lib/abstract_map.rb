$: << File.expand_path(File.dirname(__FILE__) + "/lib")

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
  
  def includes_key?(key)
    raise "abstractMethodError"
  end
  
  def includes_value?(value)
    raise "abstractMethodError"
  end
  
  def size
    raise "abstractMethodError"
  end
end
