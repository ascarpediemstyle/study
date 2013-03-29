# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + "/FileData"
require File.dirname(__FILE__) + "/LineAnalysis"
require File.dirname(__FILE__) + "/MecabManager"


def init_by(file_name)
  
  file_data = FileData.new
  mecab_manager = MecabManager.new
  
  file = File.open(file_name,"r")
  file.each_line do |line|    
    node = mecab_manager.mecab.parseToNode(line)    
    begin
      node = node.next
      
      l = LineAnalysis.new
      l.word = node.surface
      l.word_info = node.feature     
      file_data.add_to_dic(l)
    end until node.next.feature.include?("BOS/EOS")
  end
  file.close()
  return file_data
end

file_data = init_by("./data/ミルズ.txt")
file_data.write_only_count_over(5)
