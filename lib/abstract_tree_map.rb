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
  
#  # Root Insertion
#  
#  def insertT(node, assoc)
#    if (node.empty?) 
#      return new_leaf(assoc);
#    end
#
#    if (assoc.key() < node.data.key())
#      node.left = insertT(node.left, assoc) 
#      node = rotateRight(node)
#    else 
#      node.right = insertT(node.right, assoc) 
#      node = rotateLeft(node)
#    end
#
#    return node;
#  end
#
#  def insert(assoc)
#    node = add(assoc)
#    node = insertT(node, assoc)
#  end
  
  # Alle Methoden die nicht unterstützt werden abfangen, und an den tree weiter delegieren.
  def missing_method(method, *args, &block)
    @tree.send(method, *args, &block)
  end
end
