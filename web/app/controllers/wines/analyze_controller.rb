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
    
    @result_dic.each{|wine_id,result|
      
      result.wrod_dic.each{|surface,data|        
        
        info = CommentInfo.new
        info.wine_id = wine_id
        info.word = data.surface
        info.remarks = data.feature
        info.count = data.count
        
        info.save
      }
    }
    
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wine }
    end
  end
end
