

class FileData
  def initialize()
    @word_dic = {}    
  end
  attr_accessor :word_dic
  
  def add_to_dic(lineAnalysis)
    if @word_dic.key?(lineAnalysis.word)
      @word_dic[lineAnalysis.word].count_up
    else
      @word_dic.store(lineAnalysis.word,lineAnalysis)    
    end
  end
  
  def write_only_count_over(number)
    @word_dic.each {|word,line_analysis|
      if line_analysis.count >= number
        puts line_analysis.to_s()
      end      
    }
  end
  
 
end

