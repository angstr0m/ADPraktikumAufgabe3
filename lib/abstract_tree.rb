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
    
  end
  
  def right?(node)
    
  end
  
  #invariant
  def invariant?
    
  end
  
  # access
  def parent
    
  end
end
