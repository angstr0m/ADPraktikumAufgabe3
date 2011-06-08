require './abstract_map'

class SortedArrayMap < AbstractMap
  def initialize(dafault)
    super(default)
    @array = []
  end
  
  def empty?()
    return @array.empty?()
  end
  
  def fetch(key = nil, &block)
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
  
  def each(&block)
    @array.each {|elem|
      block.call(elem.key, elem.value)
    }
  end
  
  # clone ist bereits in Object ausreichend implementiert!
  
  def sort
    # Ist bereits sortiert!
    return self
  end
  
  def to_sorted_a
    #TODO Ist das so richtig? Das Array ist eigentlich schon sortiert soweit es geht! Außer den Hash-Keys bleibt kein anderes Sortier-Kriterium.
    return @array
  end
  
  # == ist in Object ausreichend implementiert!
  
  def eql?(other)
    return (hash().eql?(other.hash))
  end
  
  def hash
    return @array.hash
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