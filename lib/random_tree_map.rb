# To change this template, choose Tools | Templates
# and open the template in the editor.

class RandomTreeMap < AbstractTreeMap
  def initialize(default)
    super(default)
  end
  
  def []=(key, value)
    @tree.addRandom(Assoc.new(key,value))
  end
end
