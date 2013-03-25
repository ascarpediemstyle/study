require File.dirname(__FILE__) + '/InputData'

$INPUT_NO = 2 #入力層のセル数
$HIDDEN_NO = 2 #中間層のセル数
$ALPAH = 20 #学習係数
$data_file_name = 'input.txt'

def read_data()  
  lines = Hash.new
  File.open($data_file_name,"r") do |io|
    index = 0;
    while line = io.gets      
      splited_line = line.split(",")
      data = InputData.new(index)
      splited_line.each{|term|        
        data.add_col_data(term)
      }
      lines.store(data.index,data)      
      index += 1
    end
  end  
  return lines
end

def init_wh()
  array = Array.new($HIDDEN_NO){|i| Array.new($HIDDEN_NO,0)}
  for i in 0.step($HIDDEN_NO-1,1)
    for j in 0.step($INPUT_NO,1)
      array[i][j] = Random.rand
    end
  end
  return array
end

def init_wo()
  array = Array.new($HIDDEN_NO,0)
  for i in 0.step($HIDDEN_NO-1,1)
    array[i] = Random.rand    
  end
  return array
end

def init_e()
  array = [$HIDDEN_NO]
  for i in 0.step($HIDDEN_NO,1)    
    array[i] = Random.rand    
  end
end

def print(wh,wo,e,input_data)
  puts "wh-------"
  wh.each{|i|
    i.each{|j|
      puts "#{i},#{j}"
    }    
  }
  puts "wo-------"
  wo.each{|i|
    puts "#{i}"        
  }
end

def sigmoid_function(val)
  return 1.0/(1.0 + Math.exp(-1.0 * val))
end

def olearn(wo,e,line,calc_result)
  o = calc_result.output_val
  d = (line.get_col_data(2).to_i - o) * o * (1 - o)
  0.step(wo.size-1,1){|i|           
     wo[i] += $ALPAH*calc_result.hi[i]*d    
  }
  e[2] == e[2] + $ALPAH*(-1.0)*d
  
end

def forward(wh,wo,e,line)
  u = 0.0
  hi = []
  0.step(wh.size-1,1){|i|
    0.step(InputData::COL_COUNT - 1,1){|j|
      u += line.get_col_data(j).to_i * wh[i][j]      
      puts "#{i},#{j}"
    }    
    u -= e[i]
    hi[i] = sigmoid_function(u)
  }
  o = 0
  0.step(wo.size-1,1){|i|
    o+=hi[i]*wo[i]    
  }
  o-=e[2]    
  v = sigmoid_function(o)
  ret = CalcResult.new
  ret.output_val = v
  ret.hi = hi
  return ret
end

input_data = read_data()
wh = init_wh()
wo = init_wo()
e = init_e()
0.step(input_data.size - 1,1){|i|
  line = input_data[i]
  ret = forward(wh,wo,e,line)
  olearn(wo,e,line,ret)
}

v = print(wh,wo,e,input_data)
