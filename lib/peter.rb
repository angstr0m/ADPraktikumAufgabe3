$:.unshift File.join(File.dirname(__FILE__),'..','lib')
$LOAD_PATH << '/lib'

require 'sorted_tree_map'

test = SortedTreeMap.new()

test["a"]=1
test["b"]=2
test["c"]=3