class Gene
  def initialize()
    @data = nil
    @val = 0.0
    @eval = 0.0
  end
  attr_accessor :data,:val,:eval
  
  def to_s
    return "#{@data}, #{@val} , #{@eval}"
  end
  
end