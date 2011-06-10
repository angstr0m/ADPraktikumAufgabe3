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
    if (tree.nil?)
      raise "Tree is empty!"
    end
    @left = tree
    tree.parent = self
    
#    if (!invariant?)
#      raise "Invariante verletzt!" 
#    end
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
    node = add(assoc)
    
    while(!node.root?)
      if (node.parent.left?(node))
        node.rotateRight(node.parent)
      elsif(node.parent.right?(node))
        node.rotateLeft(node.parent)
      end
    end
  end
  
  #Invarianten
  def invariant?
    # Sortierreihenfolge überprüfen
    if (left != nil && !left.empty?)
      if(!(left.data.key < self.data.key))
        puts "Fehler: left-key nicht kleiner als self-key!" + " left-key: " + left.data.key.to_s + " self-key: " + self.data.key.to_s + "\n Baum: \n" + to_s_indented
        
        return false
      end
    end
    
    if (right != nil && !right.empty?)
      if(!(right.data.key > self.data.key))
        puts "Fehler: right-key nicht groesser als self-key!" + " right-key: " + right.data.key.to_s + " self-key: " + self.data.key.to_s  + "\n Baum: \n" + to_s_indented
        return false
      end
    end
    
    # Doppelverkettung prüfen
    if (parent == nil)
      puts "Fehler: parent ist nil!"
      return false
    end
    
    if (!(parent.right?(self) || parent.left?(self)) && !parent.handle?)
      puts "Fehler: Dieser Baum ist weder rechter noch linker Sohn seines parents!" + "\n Baum: \n" + to_s_indented
      return false
    end
    
    return true
  end
  
  #Prädikate
  def left?(node)
    return left == node
  end
  
  def right?(node)
    return right == node
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
    block.call(self)
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
    if(@data.key.eql?(key))
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