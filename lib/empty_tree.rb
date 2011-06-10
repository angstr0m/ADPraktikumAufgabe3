#require './abstract_tree'

class EmptyTree < AbstractTree
  def initialize(parent)
    super(parent)
  end
  
  # Die Suche hat auf einem leeren Baum geendet. Dieser wird zurückgegeben.
  def find(key)
    return self
  end
  
  # Traversierungen
  def each_post(&block)
    return self
  end
  
  def each_pre(&block)
    return self
  end
  
  def each_in(&block)
    return self
  end
  
  def reduce(empty_accu, &block)
    return empty_accu
  end
  
  def size 
    return 0
  end
  
  def to_s
    "EMPTYNODE"
  end
  
  def to_s_indentedR(accu)
    return accu
  end
  
  # Eigenschaften
  
  def tree?
    return false
  end
  
  # Einfügen
  def addRandom(assoc) 
    add(assoc) 
  end
end
