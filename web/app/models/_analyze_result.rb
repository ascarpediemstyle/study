class AnalyzeResult < ActiveRecord::Base      
  def initialize
    @wine_id = ""
    @word = ""
    @count = 1
    @remarks = ""
  end   
  attr_accessible :id,:count, :remarks, :wine_id, :word 
  attr_accessor :id,:count, :remarks, :wine_id, :word
  
  def count_up()
    @count +=1
  end

  def to_s()
    return "#{@word} #{@count}"  
  end
  
end
