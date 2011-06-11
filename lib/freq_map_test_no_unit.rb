# To change this template, choose Tools | Templates
# and open the template in the editor.

$: << File.expand_path(File.dirname(__FILE__) + "/lib")

require './assoc'
require './Extensions_OO_V1'
require './abstract_map'
require './abstract_tree_map'
require './random_tree_map'
require './sorted_tree_map'
require './abstract_tree'
require './empty_tree'
require './sorted_tree'
require './sized_sorted_tree'
require './freq_map'
require './abstract_tree_map'

class FreqMapTest
  def initialize
    @map = FreqMap.new()
  end
  
  def fillWithMobyDick
    @map.fillWithText()
  end
  
  def writeTestDataToFile(file)
    
    textDocument = file
    
    @map.count_map.each {|key, value|
      string = "Key: " + key.to_s + " Anzahl: " + value.to_s + "\n"
      textDocument.write(string)
    }
  end
end

class BalanceTest
  def self.getBalanceForTree(tree)
    currentPathLength = tree.reduce(0){|l,r,n|
      n.path_length + l + r
    }
    optimalPathLength = tree.size * Math.log2(tree.size/2)
    
    return (currentPathLength / optimalPathLength) * 100
  end
end

# Häufigkeitstabelle

test = FreqMapTest.new
testfile = File.new("./countmap.txt", "w")

test.fillWithMobyDick
test.writeTestDataToFile(testfile)

puts "Arbeit abgeschlossen!"