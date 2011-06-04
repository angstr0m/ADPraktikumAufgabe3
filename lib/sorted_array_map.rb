require './abstract_map'

class SortedArrayMap < AbstractMap
  def initialize()
    @array = []
  end
  
  def empty?()
    return @array.empty?()
  end
  
  def fetch(key, &block)
    if (block_given?)
      return @array.find &block
    else
      return @array.find {|assoc| assoc.key.eql?(key)}
    end
  end
  
  def find_index(key)
    if (empty?)
      return nil
    else
      return find_index_recursion(key, 0..(@array.size - 1))
    end
  end
  
  def [](key)
    if(@array.find {|assoc| assoc.key.eql?(key)} == nil)
      if (@default)
        return @default
      else
        return nil
      end
    end
  end
  
  def []= (key, value)
    newAssoc = Assoc[key, value]
    
    if (self.empty?)
      @array[0] = newAssoc
      return
    end
    
    index = find_index(key)
    
    # Ist der key schon vorhanden?
    if (index == nil)
      # Falls der key nicht vorhanden ist, wird das neue key-value Paar sortiert eingefügt.
      i = @array.size
      
      while (i > 0 and @array[i-1].key.hash > newAssoc.key.hash) do
        @array[i] = @array[i - 1]
        i -= 1
      end
      
      @array[i] = newAssoc
    else
      # Falls der key vorhanden ist, wird der alte Wert für value mit dem neuen überschrieben.
      @array[index].value = newAssoc.value
    end
  end
  
  def to_s
    output_string = ""
    
    @array.each do |elem|
      output_string += elem.to_s + ", "
    end
    
    return output_string
  end
  
  private
  
  def find_index_recursion(key, intervall)
    
    if (intervall.first.eql?(intervall.last))
      if (@array[intervall.first].key.hash.eql?(key.hash))
        # Gesuchtes Element gefunden!
        return intervall.first
      else
        # Gesuchtes Element ist nicht in dieser Datenstruktur enthalten!
        return nil
      end
    end
    
    if (intervall.last.eql?(intervall.first + 1))
      if (@array[intervall.first].key.hash.eql?(key.hash))
        # Gesuchtes Element gefunden!
        return intervall.first
      elsif (@array[intervall.last].key.hash.eql?(key.hash))
        return intervall.last
      else
        # Gesuchtes Element ist nicht in dieser Datenstruktur enthalten!
        return nil
      end
    end
    
    actual_index = (intervall.max - intervall.min) / 2
    actual_key = @array[actual_index].key
    
    # Rekursion auf der entsprechenden Hälfte des Arrays fortführen
    if (key.hash > actual_key.hash)
      return find_index_recursion(key, (intervall.min + actual_index)..intervall.max)
    else
      return find_index_recursion(key, intervall.min..(intervall.min + actual_index))
    end
  end
end

puts (0..1).last

test = SortedArrayMap.new
test["test2"] = 3
test["test1"] = 1
test["test1"] = 2
test["test3"] = 3
test["test4"] = 1
test["test5"] = 2

puts test.to_s()
puts test.find_index("test2")