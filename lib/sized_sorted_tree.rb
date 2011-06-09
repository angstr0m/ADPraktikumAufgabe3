#require './sorted_tree'

class SizedSortedTree < SortedTree
  def initialize(parent, data, leftSubTree=EmptyTree.new(nil), rightSubTree=EmptyTree.new(nil))
    super(parent, data, leftSubTree, rightSubTree)
    @size = 1
  end
  
  def size
    return @size
  end
  
  def add(data)
    @size = size + 1
    super.add(data)
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
