require './empty_tree'
require './sorted_tree'

class AbstractTree
  def initialize(parent)
    @parent = parent
  end
  
  # Klassenmethoden
  
  def self.new_empty
    return EmptyTree.new()
  end
  
  def self.new_leaf(data)
    return SortedTree.new(data, new_empty(), new_empty())
  end
  
  def self.new_node(data, leftSubTree, rightSubTree)
    newTree = SortedTree.new(data, leftSubTree, rightSubTree)
    newTree.left = leftSubTree
    newTree.right = rightSubTree
    return newTree
  end
  
  # Prädikate
  
  def tree?
    return inner? # TODO What I am supposed to do here O_O???
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
    return false # TODO Kann ein Abstract tree überhaupt jemals ein handle sein? Dafür ist doch die abstractTreeMap zuständig.
  end
  
  def left?(node)
    return parent.left == self
  end
  
  def right?(node)
    return parent.right == self
  end
  
  #Invarianten
  
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
  
  def parent=(parent)
    @parent = parent
  end
  
  # Bäume ersetzen
  def replace(oldChild, newChild)    
    if (oldChild.left?)
      self.left=(newChild)
    end
    
    if (oldChild.right?)
      self.right=(newChild)
    end
  end
end
