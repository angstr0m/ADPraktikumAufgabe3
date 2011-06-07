require './abstract_tree'

class SortedTree < AbstractTree
  def initialize(parent, data, left, right)
    super.new(parent)
    @data = data
    @left = left
    @right = right
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
end
