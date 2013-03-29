#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
require 'rubygems'
require 'MeCab'

class MecabManager
   
  def initialize()    
    @mecab = create_mecab()
  end
  attr_accessor :mecab  

 
  def create_mecab()
    dir_path ="/usr/local/Cellar/mecab/0.996/lib/mecab/dic/"
    dir_name ="ipadic"
    s = "-d #{dir_path}#{dir_name}"
    mecab =MeCab::Tagger.new(s)
    return mecab
  end
  private :create_mecab  
  
 
end



