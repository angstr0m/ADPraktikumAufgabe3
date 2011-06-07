require './abstract_tree'

class EmtpyTree < AbstractTree
  def initialize(parent)
    super(parent)
  end
  
  # Die Suche hat auf einem leeren Baum geendet. Dieser wird zurückgegeben.
  def find(key)
    return self
  end
end
