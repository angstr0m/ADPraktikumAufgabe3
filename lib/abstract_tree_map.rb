# To change this template, choose Tools | Templates
# and open the template in the editor.
require './empty_tree'
require './sorted_tree'

class AbstractTreeMap < AbstractMap
  def initialize
    @tree = AbstractTree.new_empty()
  end
  
  def replace(oldChild, newChild)
    oldChild.parent = nil
    @tree = newChild
    newChild.parent = self
  end
  
  def find_node(key, &block)
    node = @tree.find(key)
    
    if (block_given?)
      return yield(node)
    end
    
    return node
  end
  
  def add(data)
    node = find_node(data.key)
    
    if (node.empty?)
      node.replace(node, new_leaf(data))
    else
      node.data.value = data.value
    end
  end
  
  # Alle Methoden die nicht unterstützt werden abfangen und an den tree weiter delegieren.
  def missing_method(method, *args, &block)
    @tree.send(method, *args, &block)
  end
end
