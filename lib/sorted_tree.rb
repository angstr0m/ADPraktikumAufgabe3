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
end
