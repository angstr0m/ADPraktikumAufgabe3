# To change this template, choose Tools | Templates
# and open the template in the editor.

class Assoc
  @key
  @value
  
  def initialize(keyValueArray)
    if (keyValueArray.size != 2)
      raise "ArgumentArray has the wrong size! The size of the Array must be 2."
    end
    
    @key = keyValueArray[0]
    @value = keyValueArray[1]
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
