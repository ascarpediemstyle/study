require 'rubygems'
require 'MeCab'
include Math

class CorrelationAnalyzer

  def self.analyze(wine)    
    line = wine.comments
    info = create_analyze_result_info_by_line(wine.wine_id,line)
    return info
  end
   
  def self.create_analyze_result_info(wine_id)
  
    info = AnalyzeResultInfo.new
    rows = AnalyzeResult.find_all_by_wine_id(wine_id)
    mecab = create_mecab()
      
    rows.each do |row|
            
      result = AnalyzeResult.new
      result.wine_id = wine_id
      result.word = row.word
      result.remarks = row.remarks     
      info.add_to_dic(result)
    end      
    return info
  end 
  
  def self.create_analyze_result_info_by_line(wine_id,line)
  
    info = AnalyzeResultInfo.new
    mecab = create_mecab() 
      
    node = mecab.parseToNode(line)    
    begin
      node = node.next
      
      result = AnalyzeResult.new
      result.wine_id = wine_id
      result.word = node.surface
      result.remarks = node.feature     
      result.count = 1;
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
  
  def self.calc_correlation(src_wine,dst_wine)
    
    sum_of_squares = 0.0
    
    src_wine.analyze_results_info.word_dic.each do |word,src_info|
      if dst_wine.analyze_results_info.word_dic.include?(word)
        dst_info = dst_wine.analyze_results_info.word_dic[word]
        
        diff = dst_info.count.to_i - src_info.count.to_i
        sum_of_squares += Math::sqrt(diff ** 2)
        
      end
    
    end
    
    return 1.0/(1 + sum_of_squares)
  end  
  
  def make_gruff(src_wine,dst_wine)
    sum_of_squares = 0.0
    
    src_wine.analyze_results_info.word_dic.each do |word,src_info|
      if dst_wine.analyze_results_info.word_dic.include?(word)
        dst_info = dst_wine.analyze_results_info.word_dic[word]
        
        diff = dst_info.count.to_i - src_info.count.to_i
        sum_of_squares += Math::sqrt(diff ** 2)
        
      end
    
    end
    
    return 1.0/(1 + sum_of_squares)
  end
  
end

class AnalyzeResultInfo
  
  def initialize()
    @word_dic = {}    
  end
  attr_accessor :word_dic
  
  def add_to_dic(result)
    if @word_dic.key?(result.word)
      r = @word_dic[result.word]
      @word_dic[result.word].count = r.count.to_i + 1
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



  
