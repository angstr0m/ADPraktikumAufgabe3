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
      return_node = AbstractTree.new_leaf(data)
      node.parent.replace(node, return_node)
    else
      return_node = node
      node.data.value = data.value
    end
    
    return return_node
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
        return (l + 1)
      else
        return (r + 1)
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
  
  def min_possible_tree_path_length
    elems_per_level = 1
    erg = 0
    range = (0..(Math.log2(size).floor))
    range.each {|level|
      if(level == range.last)
        # if in the last level, just add path_lengths for not yet inserted nodes
        erg += (size - (2**(level)-1)) * level
      else
        erg += elems_per_level * level
      end
      elems_per_level *= 2
    }
    return erg
  end
  
  def path_length
    node = self
    length = 0
    
    while(!node.root?)
      length += 1
      node = node.parent
    end
    
    return length
  end
  
  def balance
    return max_depth-min_depth
  end
  
  # Ausgabe
  def to_s
    reduce("") {|l,r,n|
      "[" + n.data.to_s + l + r + "]" 
    }
  end
  
  def to_s_indented
    acc = ""
    each_pre {|elem|
      tiefe = "\t" * elem.path_length
      
      if(elem.parent.left?(elem))
        acc += tiefe + elem.data.to_s + "\n"
        if( elem.parent.right.empty?)      
          acc += tiefe + "EMPTY" + "\n"
        end
      else
      
      if (elem.parent.left.empty?)
        acc += tiefe + "EMPTY" + "\n"
      end
      acc += tiefe + elem.data.to_s + "\n"
      end
    }
    acc
  end
end