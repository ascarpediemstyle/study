require "CorrelationAnalyzer"


class Wines::AnalyzeController < ApplicationController
  
  # GET /wines/analyze/1
  # GET /wines/analyze/1.json
  def show    
    
    @wines = Wine.all
    @wine = Wine.find(params[:id])
        
    @analyze_results = AnalyzeResult.find_all_by_wine_id(params[:id])
    @wine.analyze_results_info = CorrelationAnalyzer::create_analyze_result_info(params[:id])
    
    @wines.each do |wine|
      wine.analyze_results_info = CorrelationAnalyzer::create_analyze_result_info(wine.wine_id)
    end  
    
   
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wine }
    end
  end
  
  def destroy
    
    respond_to do |format|
      format.html { redirect_to wines_url }
      format.json { head :no_content }
    end
  end
  
  
  # GET /wines/analyze/1/detail
  # GET /wines/analyze/1/detail.json
  def detail    
    
    @src_wine = Wine.find(params[:src_id])        
    @dst_wine = Wine.find(params[:dst_id])         
    
    
    respond_to do |format|
      format.html # dtail.html.erb
      format.json { render json: @wine }
    end    
  end
  
  def image    
    
    @src_wine = Wine.find(params[:src_id])        
    @dst_wine = Wine.find(params[:dst_id])          
    
    @src_wine.analyze_results_info = CorrelationAnalyzer::create_analyze_result_info(@src_wine.wine_id)
    @dst_wine.analyze_results_info = CorrelationAnalyzer::create_analyze_result_info(@dst_wine.wine_id)
    
    g = Gruff::Dot.new 500
    g.title = "My Graph" 

    g.theme_37signals

    #g.data("data1", @src_wine.analyze_results_info.word_dic.values )
    g.data("data2", [7, 8, 7, 10, 8, 9])
    g.data("data3", [1, 2, 3, 5, 9, 8])
    g.data("data4", [9, 9, 8, 9, 10, 9])

    g.labels = {0 => '2010/01', 2 => '2010/03', 4 => '2010/05'}
    
    file_name = "t.jpg"    

    send_data(g.to_blob, :type => 'image/png', :disposition=>'inline', :filename => file_name)
  end
  
  
  
end
