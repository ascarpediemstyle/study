class Wine < ActiveRecord::Base
  def after_initialize
    @analyze_results_info = AnalyzeResultInfo.new  
  end
  attr_accessible :comments, :id, :price, :wine_name
  attr_accessor :analyze_results_info 
  
end
