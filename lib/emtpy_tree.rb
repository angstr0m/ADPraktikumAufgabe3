require './abstract_tree'

class EmtpyTree < AbstractTree
  def initialize(parent)
    super(parent)
  end
  
  def find(key)
    return self
  end
end
