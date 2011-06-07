require './empty_tree'
require './sorted_tree'

class AbstractTree
  def initialize(parent)
    @parent
  end
  
  def self.new_empty
    return EmptyTree.new()
  end
  
  def self.new_leaf(data)
    return SortedTree.new(data, new_empty(), new_empty())
  end
  
  def self.new_node(data, leftSubTree, rightSubTree)
    return SortedTree.new(data, leftSubTree, rightSubTree)
  end
  
  # predicates
  def tree?
    
  end
  
  def empty?
    return self.instance_of?(EmptyTree)
  end
  
  def leaf?
    return (left.empty? && right.empty?)
  end
  
  def inner?
    return (!left.empty? || !right.empty?)
  end
  
  def root?
    return parent.handle?
  end
  
  def handle?
    
  end
  
  def left?(node)
    return parent.left == self
  end
  
  def right?(node)
    return parent.right == self
  end
  
  #invariant
  def invariant?
    # Sortierreihenfolge überprüfen
    if (left != nil)
      if(!left.data < self.data)
        return false
      end
    end
    
    if (right != nil)
      if(!left.data > self.data)
        return false
      end
    end
    
    # Doppelverkettung prüfen
    if (parent == nil)
      return false
    end
    
    if (!(right? || left?))
      return false
    end
  end
  
  # access
  def parent
    return @parent
  end
end
