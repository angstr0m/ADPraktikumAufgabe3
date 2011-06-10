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
    
    return return_node
  end
  
  # Setter
  def left=(tree)
    if (tree.nil?)
      raise "Tree is empty!"
    end
    @left = tree
    tree.parent = self
    
#    if (!invariant?)
#      raise "Invariante verletzt!" 
#    end
    
    recalculateSizeR()
  end
  
  def right=(tree)
    if (tree.nil?)
      raise "Tree is empty!"
    end
    @right = tree
    tree.parent = self
    
#    if (!invariant?)
#      raise "Invariante verletzt!" 
#    end
    
    recalculateSizeR()
  end
    
  # Bäume ersetzen
  def replace(oldChild, newChild)    
    if (left?(oldChild) && right?(oldChild))
      raise "Something has gone horribly wrong!"
    end
    
    # Nicht das self wegnehmen!!!! ES IST UNFASSBAR WICHTIG!!!
    if (left?(oldChild))
      # DENK NICHT MAL DRAN ES ANZUFASSEN!
      self.left=(newChild)  
    elsif (right?(oldChild))
      # DAS AUCH NICHT!!!
      self.right=(newChild)
    end
    
    oldChild.parent = nil
    
    recalculateSizeR()
  end
  
  # size neu berechnen
  def recalculateSizeR()
        
    @size = 1 + left.size + right.size
    
    if (!parent.nil? && !root?)
      parent.recalculateSizeR()
    end
  end
  
  # Randomisiertes einfügen
  
  def addRandom(assoc)
    
    node = find(assoc.key)
    
    if(!node.empty?)
      node.data.value = assoc.value
      return
    end
    
    add_as_root = (rand(size+1)== 0) 
 
    if add_as_root 
      addRoot(assoc) 
    elsif (assoc.key < data.key)  
      left.addRandom(assoc)  
    else         
      right.addRandom(assoc) 
    end
    
    recalculateSizeR()
  end
end
