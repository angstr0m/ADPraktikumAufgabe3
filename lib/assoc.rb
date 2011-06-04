# To change this template, choose Tools | Templates
# and open the template in the editor.

class Assoc
  @key
  @value
  
  def initialize(key, value)  
    @key = key
    @value = [value]
  end
  
  def self.[](key, value)
    return Assoc.new(key, value)
  end
  
  def to_s
    return "Key: " + @key.to_s() + " Value: " + @value.to_s()
  end
  
  def eql?(other)
    if (other.class != Assoc)
      raise "Compared element must be a Assoc!"
    end
        
    if (!assoc.key.eql?(other.key))
      return false
    end
    
    if (!assoc.value.eql?(other.value))
      return false
    end
    
    return true
  end
end