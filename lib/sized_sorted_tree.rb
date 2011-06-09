#require './sorted_tree'

class SizedSortedTree < SortedTree
  def initialize(parent, data, leftSubTree=EmptyTree.new(nil), rightSubTree=EmptyTree.new(nil))
    p "---------------------"
    p leftSubTree.class
    p "---------------------"
    super(parent, data, leftSubTree, rightSubTree)
    @size = super.size
  end
  
  def size
    return @size
  end
  
  # Randomisiertes einfügen
  
  def addRandom(assoc) 
    add_as_root = (rand(size+1)== 0) 
 
    if add_as_root 
      addRoot(assoc) 
    elsif (data.key < assoc.key)  
      left.addRandom(assoc)  
    else         
      right.addRandom(assoc) 
    end
    
    @size = size + 1
  end
end
