require "CorrelationAnalyzer"


class Wines::AnalyzeController < ApplicationController
  
  
  # GET /wines/analyze/1
  # GET /wines/analyze/1.json
  def show
    
    @wines = Wine.all
    @wine = Wine.find(params[:id])
    
    @result_dic = Hash.new
    
    @wines.each{|target_wine|
      result = CorrelationAnalyzer::analyze(@wine,target_wine)
      @result_dic.store(target_wine.id,result)
    }
    
    @result_dic.each{|wine_id,info|
      
      info.word_dic.each{|word,data|                      
        if data.present? then data.save end
      }
    }
    
    
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
  
  
  
end
