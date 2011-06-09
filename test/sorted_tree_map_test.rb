# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')
$LOAD_PATH << '/lib'

require 'test/unit'
require 'sorted_tree_map'

class SortedTreeMapTest < Test::Unit::TestCase
  def setupEmptyTree
    test = SortedTreeMap.new()

    return test
  end
  
  def setupFilledTree
    
    test = SortedTreeMap.new()

    test["a"]=1
    test["b"]=2
    test["c"]=3
    test["d"]=4
    test["e"]=5
    test["f"]=6
    
    return test
  end
  
  def setupFilledTreeWithDefault(default)
    
    test = SortedTreeMap.new(default)

    test["a"]=1
    test["b"]=2
    test["c"]=3
    test["d"]=4
    test["e"]=5
    test["f"]=6
    
    return test
  end
  
  def test_empty
    test = setupEmptyTree
    assert_equal(true, test.empty?)
    test = setupFilledTree
    assert_false(test.empty?)
  end
  
  def test_includes_key
    test = setupEmptyTree
    assert_false(test.includes_key?("a"))
    test = setupFilledTree
    assert_equal(true, test.includes_key?("a"))
    assert_equal(false, test.includes_key?("g"))
  end
  
  def test_includes_value
    test = setupEmptyTree
    assert_false(test.includes_value?(1))
    test = setupFilledTree
    assert_true(test.includes_value?(1))
    assert_false(test.includes_value?(7))
  end
  
  def test_fetch
    test = setupFilledTree
    
    assert_equal(1, test.fetch("a"))
    assert_equal("defaultWert", test.fetch("z", "defaultWert"))
    
    assert_raise KeyError do
      assert_raise(test.fetch("g"))
    end
    
    test = setupFilledTreeWithDefault("Default-Wert")
    
    assert_equal("Default-Wert", test.fetch("g"))
  end
  
  def test_get
    test = setupFilledTree
    
    assert_equal(1, test["a"])
    assert_equal(nil, test["z"])
    
    test = setupFilledTreeWithDefault("default")
    
    assert_equal("default", test["z"])
  end
  
  def test_set
    test = setupFilledTree
    
    test["a"]=2
    assert_equal(2,test["a"])
  end
end
