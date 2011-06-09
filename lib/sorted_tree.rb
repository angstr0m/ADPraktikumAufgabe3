#require './abstract_tree'

class SortedTree < AbstractTree
  def initialize(parent, data, leftSubTree, rightSubTree)
    super(parent)
    @data = data
    @left = nil
    @right = nil
    
    @left = leftSubTree
    @left.parent = self
    
    @right = rightSubTree
    @right.parent = self
  end
  
  def data
    return @data
  end
  
  def left
    return @left
  end
  
  def right
    return @right
  end
  
  # Setter
  def left=(tree)
    @left = tree
    tree.parent = self
  end
  
  def right=(tree)
    @right = tree
    tree.parent = self
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
  end
  
  # Root insertion
  
  def addRoot(assoc)
    newNode = add(assoc)
    
    addRootT(newNode ,assoc)
  end
  
  def addRootT(node, assoc)
    if (assoc.key() < node.data.key())
      node.left = addRoot(node.left, assoc) 
      node = rotateRight(node)
    else 
      node.right = addRoot(node.right, assoc) 
      node = rotateLeft(node)
    end
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
  
  # Traversierungen
  def each_post(&block)
    left.each_post(&block)
    right.each_post(&block)
    block.call(self)
  end
  
  def each_pre(&block)
    block.call(self)
    left.each_pre(&block)
    right.each_pre(&block)
  end
  
  def each_in(&block)
    left.each_in(&block)
    block.call(&block)
    right.each_in(&block)
  end
  
  def reduce(empty_accu, &block)
    left_accu = left.reduce(empty_accu, &block)
    right_accu = right.reduce(empty_accu, &block) 
    
    if (left_accu.nil? || right_accu.nil?)
      raise "left oder right accu nil!"
    end
    
    erg = block.call(left_accu, right_accu, self)
    
    if (erg.nil?)
      raise "Ergebnis des Blocks ist nil!"
    end
    
    return erg
  end
  
  # Suche
  def find(key)
    if(@data.key == key)
      return self
    end
    
    if (key > data.key)
      return right.find(key)
    else
      return left.find(key)
    end
  end
  
  # Bäume ersetzen
  def replace(oldChild, newChild)    
    if (oldChild.left?(newChild))
      self.left=(newChild)
    end
    
    if (oldChild.right?(newChild))
      self.right=(newChild)
    end
  end
  
  # Rotieren
  
  def rotateRight(node)
    temp = node.left
    node.parent.replace(node, temp)
    node.left = temp.right
    temp.right = node
    if (!temp.invariant? || !node.invariant?)
      raise "Invariante verletzt!"
    end
    return temp
  end

  def rotateLeft(node)
    temp = node.right
    node.parent.replace(node, temp)
    node.right = temp.left
    temp.left = node
    if (!temp.invariant? || !node.invariant?)
      raise "Invariante verletzt!"
    end
    return temp
  end
end
