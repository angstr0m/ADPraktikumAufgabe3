require './abstract_tree_map'

class SortedTreeMap < AbstractTreeMap
  def initialize(default=nil)
    super(default)
  end
end

test = SortedTreeMap.new()

p SizedSortedTree.new(nil,"bla").size

test["a"]=1
test["b"]=2
test["c"]=3
test["d"]=4
test["e"]=5
test["f"]=6

puts test.to_s_indented

#p test.find("e").size

puts "JETZT KOMMT SIZE"
puts test.size
puts "DAS WAR SIZE!"

#puts test.max_depth