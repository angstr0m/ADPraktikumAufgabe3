# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')
$LOAD_PATH << '/lib'

require 'test/unit'
require 'sorted_tree_map'

class SortedTreeMapTest < Test::Unit::TestCase
  def setupEmptyTree
    test = SortedTreeMap.new()

    @test = test
  end
  
  def setupFilledTree
    
    test = SortedTreeMap.new()

    test["f"]=1
    test["a"]=2
    test["x"]=3
    test["d"]=4
    test["b"]=5
    test["r"]=6
    
    @test = test
  end
  
  def test_empty
    setupEmptyTree
    assert_equal(true, @test.empty?)
  end
  
  def test_includes_key
    setupFilledTree
    assert_equal(true, @test.includes_key?("a"))
    assert_equal(false, @test.includes_key?("c"))
  end
end
