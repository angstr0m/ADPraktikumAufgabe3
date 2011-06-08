# To change this template, choose Tools | Templates
# and open the template in the editor.
require './empty_tree'
require './sorted_tree'
require './assoc'

class AbstractTreeMap < AbstractMap
  def initialize(default)
    super(default)
    @tree = AbstractTree.new_empty()
  end
  
  def empty?
    @tree.empty?
  end
  
  def fetch(key, &block)
    node = @tree.find(key)
    
    if (node.empty?)
      if (@default != nil)
        return @default
      else
        raise KeyError
      end
    end
    
    if (block_given?)
      return yield block(node.data.value)
    else
      return node.data.value
    end
  end
  
  def [](key)
    return @tree.find(key).data.value
  end
  
  def []=(key, value)
    @tree.add(Assoc.new(key,value))
  end
  
  def each(&block)
    @tree.each_post(block)
  end
  
  # Clone wird von Object übernommen
  
  #TODO Was zur Hölle sollen wir hier tun?
  def sort
    raise "abstractMethodError"
  end
  
  def to_sorted_a
    raise "abstractMethodError"
  end
  
  def ==(other)
    if (other == nil)
      return false
    end
    
    if (size != other.size)
      return false
    end
    
    other.each {|elem|
      if (!self.includes_key?(elem.key))
        return false
      end
      
      if (self[elem.key] != other[elem.key])
        return false
      end
    }
    
    return true
  end
  
  def eql?(other)
    self.hash.eql?(other.hash)
  end
  
  def hash
    hash = 7
    each {|elem|
      hash = hash + 13 * elem.data.hash
    }
    return hash
  end
  
  def includes_key?(key)
    return @tree.find(key) != nil 
  end
  
  def includes_value?(value)
    @tree.each_post {|assoc|
      if (assoc.key.eql?(value))
        return true
      end
    }
    
    return false
  end
  
  def size
    @tree.size
  end
  
  def replace(oldChild, newChild)
    oldChild.parent = nil
    @tree = newChild
    newChild.parent = self
  end
  
  
  # Alle Methoden die nicht unterstützt werden abfangen, und an den tree weiter delegieren.
  def missing_method(method, *args, &block)
    @tree.send(method, *args, &block)
  end
end
