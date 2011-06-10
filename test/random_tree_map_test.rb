# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')
$LOAD_PATH << '/lib'

#require 'test/unit'
require 'abstract_tree_map'
require 'random_tree_map'
require 'sorted_tree_map'

# Erben wäre unglaublich viel besser gewesen...
# Aber die Datei wird einfach nicht géfunden :(

#class RandomTreeMapTest < Test::Unit::TestCase
#  
#  TestRange = "a".."f"
#  
#  def setupEmptyTree
#    test = RandomTreeMap.new()
#
#    return test
#  end
#  
#  def setupFilledTree
#  
#    @testKeys = (TestRange).to_a
#    @testValues = []
#    
#    test = RandomTreeMap.new()
#    
#    i = 1
#    
#    @testKeys.each {|elem|
#      test[elem]=i
#      @testValues << i
#      i += 1
#    }
#        
#    return test
#  end
#  
#  def setupFilledTreeWithDefault(default)
#    
#    @testKeys = (TestRange).to_a
#    @testValues = []
#    
#    test = RandomTreeMap.new(default)
#    
#    i = 1
#    
#    @testKeys.each {|elem|
#      test[elem]=i
#      @testValues << i
#      i += 1
#    }
#    
#    return test
#  end
#  
#  def setupReferenceHash
#    
#    @testKeys = (TestRange).to_a
#    @testValues = []
#    
#    referenceHash = Hash.new()
#    
#    i = 1
#    
#    @testKeys.each {|elem|
#      referenceHash[elem]=i
#      @testValues << i
#      i += 1
#    }
#    
#    return referenceHash
#  end
#  
#  def test_empty
#    
#    test = setupEmptyTree
#    assert_equal(true, test.empty?)
#    test = setupFilledTree
#    assert_false(test.empty?)
#  end
#  
#  def test_includes_key
#    test = setupEmptyTree
#    assert_false(test.includes_key?("a"))
#    test = setupFilledTree
#    assert_equal(true, test.includes_key?("a"))
#    assert_equal(false, test.includes_key?("g"))
#  end
#  
#  def test_includes_value
#    test = setupEmptyTree
#    assert_false(test.includes_value?(1))
#    test = setupFilledTree
#    assert_true(test.includes_value?(1))
#    assert_false(test.includes_value?(7))
#  end
#  
#  def test_fetch
#    test = setupFilledTree
#    
#    assert_equal(1, test.fetch("a"))
#    assert_equal("defaultWert", test.fetch("z", "defaultWert"))
#    
#    assert_raise KeyError do
#      assert_raise(test.fetch("g"))
#    end
#    
#    test = setupFilledTreeWithDefault("Default-Wert")
#    
#    assert_equal("Default-Wert", test.fetch("g"))
#  end
#  
#  def test_get
#    test = setupFilledTree
#    
#    assert_equal(1, test["a"])
#    assert_equal(nil, test["z"])
#    
#    test = setupFilledTreeWithDefault("default")
#    
#    assert_equal("default", test["z"])
#  end
#  
#  def test_set
#    test = setupFilledTree
#    
#    test["z"]=5
#    assert_equal(5,test["z"])
#    
#    test["a"]=2
#    assert_equal(2,test["a"])
#  end
#  
#  def test_each
#    test = setupFilledTree
#    
#    test.each {|key, value|
#      assert_true(@testKeys.include?(key))
#      assert_true(@testValues.include?(value))
#      
#      @testKeys.delete(key)
#      @testValues.delete(value)
#    }
#    
#    assert_true(@testKeys.empty?)
#    assert_true(@testValues.empty?)
#  end
#  
#  # clone von Object übernommen, daher kein test nötig
#  
#  def test_sort
#    # Es wird einfach self zurückgegeben. Nichts spannendes also.
#  end
#  
#  def test_sorted_a
#    test = setupFilledTree
#    sorted_a = test.to_sorted_a
#    
#    sorted_a.each_cons(2){|a,b|
#      assert_true(a[0] < b[0])
#    }
#  end
#  
#  def test_equal
#    test = setupFilledTree
#    referenceHash = setupReferenceHash
#    
#    assert_true(test == referenceHash)
#  end
#  
#  def test_eql?
#    test = setupFilledTree
#    referenceHash = setupFilledTree
#    
#    assert_true(test.eql?(referenceHash))
#  end
#end


test = test = SortedTreeMap.new()

test["a"]=1
test["b"]=2
test["c"]=3

puts "Das ist Peters Hütte vorm rotieren"
puts test.to_s_indented

peter = test.find("a")
peter.rotateLeft(peter)

puts "Peters Hütte wurde rotiert"
puts test.to_s_indented