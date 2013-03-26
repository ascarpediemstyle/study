class NetworkManager
  INPUT_NO = 2 #入力層のセル数
  HIDDEN_NO = 2 #中間層のセル数
  
  def initialize()
    @wh = [] #中間層の重み
    @vh =[] #中間層のしきい値
    @wo = [] #出力槽の重み
    @vo =0.0 #出力層のしきい値
    
  end
  attr_accessor :wh, :wo, :vh, :vo
  
  def init()
    init_wh()
    init_wo()
    init_vh()
    init_vo()
  end
  def init_wh()
    array = Array.new(HIDDEN_NO){|i| Array.new(HIDDEN_NO,0)}
    HIDDEN_NO.times{|i|
      (INPUT_NO + 1).times{|j|
        array[i][j] = Random.rand
      }
    }
    @wh = array
  end

  def init_wo()
    array = Array.new(HIDDEN_NO,0)
    HIDDEN_NO.times{|i|
      array[i] = Random.rand    
    }    
    @wo =  array
  end
  
  def init_vh()
    array = []
    (HIDDEN_NO).times{|i|    
      array[i] = Random.rand    
    }
    @vh = array
  end
  
  def init_vo()
    @vo = Random.rand   
  end
  
  def print()
    puts "wh-------"
    @wh.each{|whi|
      whi.each{|whij|
        puts "#{whij}"
      }    
    }
    puts "wo-------"
    @wo.each{|woi|
      puts "#{woi}"        
    }
  end

end