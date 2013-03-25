class InputData 
  COL_COUNT = 3
  
  def initialize(index)
    @index = index
    @col_list = []
  end
  attr_accessor :index
  
  
  def add_col_data(data)
    @col_list.push(data)
  end
  
  def get_col_data(col_no)
    return @col_list[col_no]
  end
  
  
end

class CalcResult
  def initialize()
    @output_val = 0.0
    @hi = []
  end
  attr_accessor :output_val, :hi
end