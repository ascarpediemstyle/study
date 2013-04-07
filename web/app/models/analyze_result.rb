class AnalyzeResult < ActiveRecord::Base
  attr_accessible :count, :id, :remarks, :wine_id, :word  
  
  def to_s()
    return "#{@attributes.word} #{@attributes.count}"  
  end
end
