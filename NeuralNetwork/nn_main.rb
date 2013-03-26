require File.dirname(__FILE__) + '/InputData'
require File.dirname(__FILE__) + '/NetworkManager'

$INPUT_NO = 2 #入力層のセル数
$HIDDEN_NO = 2 #中間層のセル数
$ALPAH = 10 #学習係数
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

def sigmoid_function(val)
  return 1.0/(1.0 + Math.exp(-1.0 * val))
end

def olearn(network_manager,line,calc_result)
  o = calc_result.output_val
  d = (line.get_col_data(2).to_i - o) * o * (1 - o)
  network_manager.wo.size.times{|i|           
     network_manager.wo[i] += $ALPAH*calc_result.hi[i]*d    
  }
  network_manager.vo = network_manager.vo + $ALPAH*(-1.0)*d
  
end

def forward(network_manager,line)
  u = 0.0
  hi = []
  network_manager.wh.size.times{|i|    
    InputData::INPUT_COL_COUNT.times{|j|
      u += line.get_col_data(j).to_i * network_manager.wh[i][j]      
    }    
    u -= network_manager.vh[i]
    hi[i] = sigmoid_function(u)
  }
  o = 0  
  network_manager.wo.size.times{|i|    
    o+=hi[i]*network_manager.wo[i]    
  }
  o-=network_manager.vo   
  v = sigmoid_function(o)
  ret = CalcResult.new
  ret.output_val = v
  ret.hi = hi
  return ret
end

input_data = read_data()
network_manager = NetworkManager.new
network_manager.init()
ret_dic = {}
200.times{|i|
  ret_list = []
  input_data.size.times {|j|
    line = input_data[j]
    ret = forward(network_manager,line)
    ret_list.push(ret)
    olearn(network_manager,line,ret)
  }
  ret_dic[i] = ret_list
}

f = File.open("out.csv","w")
f.close()
network_manager.print()
puts "output-------"
fio = File.open("out.csv","a")

ret_dic.each{|i,ret_list|
  str = "#{ret_list[0].output_val},#{ret_list[1].output_val},#{ret_list[2].output_val},#{ret_list[3].output_val}"
  fio.puts(str)
  }
fio.close()
