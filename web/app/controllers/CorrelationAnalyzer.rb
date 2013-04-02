require 'rubygems'
require 'MeCab'

class CorrelationAnalyzer
  
  def self.analyze(src_wine,dst_wine)    
    line = src_wine.comments
    info = create_analyze_result_info(src_wine.wine_id,line)
    return info
  end
   
  
  def self.create_analyze_result_info(wine_id,line)
  
    info = AnalyzeResultInfo.new
    mecab = create_mecab() 
      
    node = mecab.parseToNode(line)    
    begin
      node = node.next
      
      result = AnalyzeResult.new
      result.wine_id = wine_id
      result.word = node.surface
      result.remarks = node.feature     
      info.add_to_dic(result)
    end until node.next.feature.include?("BOS/EOS")   
    
    return info
  end 
  
  def self.create_mecab()
    dir_path ="/usr/local/Cellar/mecab/0.996/lib/mecab/dic/"
    dir_name ="ipadic"
    s = "-d #{dir_path}#{dir_name}"
    mecab =MeCab::Tagger.new(s)
    return mecab
  end  
  
end

class AnalyzeResultInfo
  
  def initialize()
    @word_dic = {}    
  end
  attr_accessor :word_dic
  
  def add_to_dic(result)
    if @word_dic.key?(result.word)
      @word_dic[result.word].count_up
    else
      @word_dic.store(result.word,result)    
    end
  end
  
  def write_only_count_over(number)
    @word_dic.each {|word,result|
      if result.count >= number
        puts result.to_s()
      end      
    }
  end 
end



  
