#require './empty_tree'
#require './sorted_tree'

class AbstractTree
  def initialize(parent)
    @parent = parent
  end
  
  # Klassenmethoden
  
  def self.new_empty
    return EmptyTree.new(nil)
  end
  
  def self.new_leaf(data)
    return SizedSortedTree.new(nil, data)
  end
  
  def self.new_node(data, leftSubTree, rightSubTree)
    newTree = SizedSortedTree.new(nil, data, leftSubTree, rightSubTree)
    return newTree
  end
  
  # Hinzufügen
  
  def add(data)
    node = find_node(data.key)
    
    if (node.empty?)
      node.parent.replace(node, AbstractTree.new_leaf(data))
    else
      node.data.value = data.value
    end
    
    return node
  end
  
  # Suchen
  
  def find_node(key, &block)
    node = find(key)
    
    if (block_given?)
      return yield(node)
    end
    
    return node
  end
  
  # Prädikate
  
  def tree?
    return true 
  end
  
  def empty?
    return self.instance_of?(EmptyTree)
  end
  
  def leaf?
    return (left.empty? && right.empty?)
  end
  
  def inner?
    return (!left.empty? || !right.empty?)
  end
  
  def root?
    return parent.handle?
  end
  
  def handle?
    return false
  end
  
  def left?(node)
    return parent.left == self
  end
  
  def right?(node)
    return parent.right == self
  end
  
  # access
  def parent
    return @parent
  end
  
  def parent=(parent)
    @parent = parent
  end
    
  # Eigenschaften
  def max
    maximum_value = self.data.value
    each_post {|node|
      if (node.data.value > maximum_value)
        maximum_value = node.data.value
      end
    }
    return maximum_value
  end
  
  def min
    minimum_value = self.data.value
    each_post {|node|
      if (node.data.value < minimum_value)
        minimum_value = node.data.value
      end
    }
    return minimum_value
  end
  
  def size
    reduce(0) {|l,r,n| l+r+1}  
  end
  
  def max_depth
    reduce(0) {|l,r,n|
      if (l > r)
        return l + 1
      else
        return r + 1
      end
    }
  end
  
  def min_depth
    reduce(0) {|l,r,n|
      if (l < r)
        return l + 1
      else
        return r + 1
      end
    }
  end
  
  def path_length
    return path_lengthR(0)
  end
  
  def path_lengthR(accu)
    if (root?)
      return accu
    else
      return parent.path_lengthR(accu + 1)
    end
  end
  
  def balance
    return max_depth-min_depth
  end
  
  # Ausgabe
  def to_s
    reduce("") {|l,r,n|
      "[" + n.to_s() + l + r + "]" 
    }
  end
  
  def to_s_indented
    reduce("") {|l,r,n|
      " " + n.to_s() + "\n"  + l + r  
    }
  end
end