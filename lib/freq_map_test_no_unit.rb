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
require './sorted_array_map'

class FreqMapTest
  def initialize(map_class=RandomTreeMap)
    @map = FreqMap.new(map_class)
    @testdata = []
  end
  
  def readInText(aTextFile = './MobyDick.txt')
    File.open(aTextFile, 'r') do |f1|
      index = 0
      while line = f1.gets
        @testdata << line
        index += 1
      end
    end
  end
  
  def benchmarkMap
    time do
      @testdata.each {|elem|
        @map.count(elem)
      }
    end
  end
  
  def calculateBalance
    currentPathLength = @map.count_map.reduce(0){|l,r,n|
      n.path_length + l + r
    }
    optimalPathLength = @map.count_map.min_possible_tree_path_length
    
    return (currentPathLength.to_f / optimalPathLength.to_f) * 100
  end
  
  def writeTestDataToFile(file)
    
    textDocument = file
    
    @map.count_map.each {|key, value|
      string = "Key: " + key.to_s + " Anzahl: " + value.to_s + "\n"
      textDocument.write(string)
    }
  end
  
  def time()
    start = Time.now
    yield
    @time = Time.now - start
  end
end

class Ergebnis
  def initialize(algorithmus, runtime, balance, sorted)
    @algorighmus = algorithmus
    @runtime = runtime
    @balance = balance
    @sorted = sorted # true, false
  end
  
  def to_s
    "Algorithmus: " + @algorighmus.to_s + " Sortiert: " + @sorted.to_s + " Runtime: " + @runtime.to_s + " Balance: " + @balance.to_s
  end
end

#  SortedTreeMap, 
TestAlgorithms = [SortedArrayMap, RandomTreeMap, Hash]
UseSortedData = true

#TestAlgorithms.each {|elem|
#  puts elem.respond_to?('min_possible_tree_path_length')
#}

# Häufigkeitstabelle

test = FreqMapTest.new
testfile = File.new("./countmap.txt", "w")

test.readInText()
test.writeTestDataToFile(testfile)
puts "Benoetigte Zeit: " + test.benchmarkMap.to_s
puts "Balance: " + test.calculateBalance.to_s

puts "Ausgabe in Datei abgeschlossen.\n"

ergebnis_array = []

TestAlgorithms.each {|algorithmus|
  puts algorithmus.to_s + " startet."
  
  puts "Nicht sortierte Daten start."
  if (!UseSortedData)
    # sorted
    test = FreqMapTest.new(algorithmus)
    test.readInText("./MobyDick.txt")
    runtime = test.benchmarkMap
    if (algorithmus == SortedTreeMap || algorithmus == RandomTreeMap)
      balance = test.calculateBalance
    else
      balance = 0
    end

    ergebnis_array << Ergebnis.new(algorithmus, runtime, balance, false)
  end
  puts "Nicht sortierte Daten Ende."
  
  if (UseSortedData)
    puts "Sortierte Daten Anfang."
    # sorted
    test = FreqMapTest.new(algorithmus)
    test.readInText("./MobyDickSortiert.txt")
    runtime = test.benchmarkMap
    
    if (algorithmus == SortedTreeMap || algorithmus == RandomTreeMap)
      balance = test.calculateBalance
    else
      balance = 0
    end

    ergebnis_array << Ergebnis.new(algorithmus, runtime, balance, true)
    puts "Sortierte Daten Ende."
    puts algorithmus.to_s + " abgeschlossen."
  end
}

puts ergebnis_array