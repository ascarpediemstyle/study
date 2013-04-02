require "CorrelationAnalyzer"


class Wines::AnalyzeController < ApplicationController
  
  
  # GET /wines/analyze/1
  # GET /wines/analyze/1.json
  def show
    
    @wines = Wine.all
    @wine = Wine.find(params[:id])
    
    @analyze_results = AnalyzeResult.find_all_by_wine_id(params[:id])
     
    
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
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wine }
    end    
  end
  
  
  
end
