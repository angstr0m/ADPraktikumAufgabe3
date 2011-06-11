# To change this template, choose Tools | Templates
# and open the template in the editor.

$: << File.expand_path(File.dirname(__FILE__) + "/lib")

class FreqMap
  
  def initialize(map_class=RandomTreeMap, data=[])
    @map = map_class.new(0)
    data.each {|elem|
      @map.count(elem)
    }
  end
  
  def count(elem)
    @map[elem]= @map[elem] + 1
  end
  
  def count_map
    return @map
  end
end