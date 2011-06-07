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
  
  # Traversierungen
  def each_post(&block)
    left.each_post(block)
    right.each_post(block)
    yield block(self)
  end
  
  def each_pre(&block)
    yield block(self)
    left.each_post(block)
    right.each_post(block)
  end
  
  def each_in(&block)
    left.each_post(block)
    yield block(block)
    right.each_post(block)
  end
  
  def reduce(empty_accu, &block)
    left_accu = left.reduce(empty_accu, block)
    right_accu = right.reduce(empty_accu, block)
    
    return yield block(left_accu, right_accu, self)
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
