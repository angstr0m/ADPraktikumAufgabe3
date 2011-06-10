class SortedArrayMap < AbstractMap
  def initialize(default = nil)
    super(default)
    @array = []
  end
  
  def empty?()
    return @array.empty?()
  end
  
  def fetch(key = nil, default = nil, &block)
    result = nil
    if (block_given?)
      result = @array.find &block
    else
      result = @array.find {|assoc| assoc.key.eql?(key)}
    end
    
    if (result.nil?)
      if (!default.nil?)
        return default
      end
      
      if (!@default.nil?)
        return @default
      end
      
      raise KeyError
    else
      return result.value
    end
  end
  
  def find_index(key)
    if (empty?)
      return -1
    else
      return find_index_recursion(key, 0..(@array.size - 1))
    end
  end
  
  def [](key)
    result = @array.find {|assoc| assoc.key == key}
    
    if(result == nil)
      if (@default)
        return @default
      else
        return nil
      end
    else
      return result.value
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
    if (index == -1)
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
  
  def ==(other)
    
    if (self.size != other.size)
      return false
    end
    
    other.each{|key, value|
      if (!self.includes_key?(key))
        return false
      end
      
      if (!self.includes_value?(value))
        return false
      end
    }
    
    return true
  end
  
  def includes_key?(key)
    return find_index(key) != -1
  end
  
  def includes_value?(value)
    each {|k, v|
      if (v == value)
        return true
      end
    }
    
    return false
  end
  
  def each(&block)
    @array.each {|elem|
      block.call([elem.key, elem.value])
    }
  end
  
  # clone ist bereits in Object ausreichend implementiert!
  
  def sort
    # Ist bereits sortiert!
    return self
  end
  
  def to_sorted_a
    arr = []
    each {|elem|
      arr << elem
    }
    return arr.sort!{|a,b| a[0] <=> b[0]}
  end
  
  # == ist in Object ausreichend implementiert!
  
  def eql?(other)
    return (hash().eql?(other.hash))
  end
  
  def hash
    return @array.hash
  end 
  
  def size
    return @array.size
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
    
    # intervall hat nur noch ein Element
    if (intervall.first.eql?(intervall.last))
      if (@array[intervall.first].key.hash.eql?(key.hash))
        # Gesuchtes Element gefunden!
        return intervall.first
      else
        # Gesuchtes Element ist nicht in dieser Datenstruktur enthalten!
        return -1
      end
    end
    
    # Spezialfall für zwei Elemente
    if (intervall.last == (intervall.first + 1))
      if (@array[intervall.first].key.hash == key.hash)
        # Gesuchtes Element gefunden!
        return intervall.first
      elsif (@array[intervall.last].key.hash == key.hash)
        return intervall.last
      else
        # Gesuchtes Element ist nicht in dieser Datenstruktur enthalten!
        return -1
      end
    end
    
    actual_index = ((intervall.max - intervall.min) / 2).ceil
    actual_key = @array[intervall.min + actual_index].key
    
    # Rekursion auf der entsprechenden Hälfte des Arrays fortführen
    if (key.hash > actual_key.hash)
      return find_index_recursion(key, (intervall.min + actual_index)..intervall.max)
    else
      return find_index_recursion(key, intervall.min..(intervall.min + actual_index))
    end
  end
end