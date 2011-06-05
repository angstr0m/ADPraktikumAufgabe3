# To change this template, choose Tools | Templates
# and open the template in the editor.
require './empty_tree'
require './sorted_tree'

class AbstractTreeMap < AbstractMap
  def initialize
    @tree = AbstractTree.new_empty()
  end
end
