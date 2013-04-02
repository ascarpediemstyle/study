class AnalyzeResult < ActiveRecord::Base
  attr_accessible :count, :id, :remarks, :wine_id, :word
  
  
  def count_up()
    if @count.blank? 
     @count = 1 
   else
     @count +=1
   end    
  end

  def to_s()
    return "#{@word} #{@count}"  
  end
end
