# To change this template, choose Tools | Templates
# and open the template in the editor.

class SortedArrayMap < AbstractMap
  def initialize(array)
    @array = array
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
    return find_index_recursion(key, @array)
  end
  
  private def find_index_recursion(key, array)
    # Wenn das array nur noch 1 Element besitzt ist das Ende der Rekursion erreicht.
    # Entweder ist das Element das gesuchte, oder das gesucht Element ist nicht enthalten!
    if (array.size == 1 )
      if (array[0].key.eql?(key))
        # Gesuchtes Element gefunden!
        return actual_index
      else
        # Gesuchtes Element nicht in dieser Datenstruktur enthalten!
        return nil
      end
    end
    
    actual_index = array.size/2
    actual_key = array[actual_index].key
    
    if (actual_key.eql?(key))
      return actual_index
    end
    
    # Rekursion auf der entsprechenden Hälfte des Arrays fortführen
    if (key > actual_key)
      return find_index_recursion(key, array.slice(actual_index..(array.size -1)))
    else
      return find_index_recursion(key, array.slice(0..actual_index))
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
    
    if (index != nil)
      einzusortierender_wert = Assoc
      j = i
      while j > 0 and compare(self[j-1], einzusortierender_wert) == 1 do
        self[j] = self[j - 1]
        j = j - 1
      end
      self[j] = einzusortierender_wert
    else
      @array[index].value << value
    end
  end
  
  def insert_sorted(assoc)
    
  end
end
