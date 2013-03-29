class LineAnalysis
  
  def initialize()
    @count = 1
    
    @word = ""
    @word_info = ""
    
  end
  attr_accessor :word, :word_info
  attr_reader :count
  
  def count_up()
    @count +=1
  end
  
  def to_s()
    return "#{@word} #{@count}"  
  end    
    
end