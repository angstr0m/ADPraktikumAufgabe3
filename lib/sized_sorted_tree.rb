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
    node = find_node(data.key)
    
    if (node.empty?)
      return_node = AbstractTree.new_leaf(data)
      node.parent.replace(node, return_node)
    else
      return_node = node
      node.data.value = data.value
    end
    
    @size = size + 1
    
    return return_node
  end
    
  # Randomisiertes einfügen
  
  def addRandom(assoc) 
    add_as_root = (rand(size+1)== 0) 
 
    if add_as_root 
      addRoot(assoc) 
    elsif (assoc.key < data.key)  
      left.addRandom(assoc)  
    else         
      right.addRandom(assoc) 
    end
    
    @size = size + 1
  end
end
