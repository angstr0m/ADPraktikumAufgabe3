require './sorted_tree'

class SizedSortedTree < SortedTree
  def initialize(parent, data, left, right)
    super(parent, data, left, right)
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
