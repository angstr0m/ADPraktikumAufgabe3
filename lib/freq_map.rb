# To change this template, choose Tools | Templates
# and open the template in the editor.

$: << File.expand_path(File.dirname(__FILE__) + "/lib")

class FreqMap
  
  def initialize(map_class=RandomTreeMap, data=[])
    @map = map_class.new(0)
  end
  
  def fillWithText(aTextFile = './MobyDick.txt')
    File.open(aTextFile, 'r') do |f1|
      index = 0
      while line = f1.gets
        count(line)
        index += 1
      end
    end
  end
  
  def count(elem)
    @map[elem]= @map[elem] + 1
  end
  
  def count_map
    return @map
  end
end