# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'abstract_map'
require 'abstract_tree'
require 'empty_tree'
require 'sorted_tree'
require 'sized_sorted_tree'
require 'assoc'

class AbstractTreeMap < AbstractMap
  def initialize(default=nil)
    super(default)
    @tree = AbstractTree.new_empty()
    @tree.parent = self
  end
  
  def empty?
    @tree.empty?
  end
  
  def handle?
    return true
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
    tree = @tree.find(key)
    if (tree.empty?)
      return @default
    else
      return tree.data.value
    end
  end
  
  def []=(key, value)
    @tree.add(Assoc.new(key,value))
  end
  
  def each(&block)
    @tree.each_post(block)
  end
  
  # Clone wird von Object übernommen
  
  def sort
    return self
  end
  
  def to_sorted_a
    arr = []
    each_in {|elem|
      arr << elem
    }
    return arr
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
    return @tree.find(key).class != EmptyTree 
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
    return @tree.size
  end
  
  def replace(oldChild, newChild)
    oldChild.parent = nil
    @tree = newChild
    newChild.parent = self
  end
  
  def to_s
    return @tree.to_s
  end
  
  # Alle Methoden die nicht unterstützt werden abfangen, und an den tree weiter delegieren.
  def method_missing(method, *args, &block)
    @tree.send(method, *args, &block)
  end
end