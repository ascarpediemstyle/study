#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
require 'rubygems'
require 'MeCab'

dir_path ="/usr/local/Cellar/mecab/0.996/lib/mecab/dic/"
dic_dir_names =["ipadic"]

mecab = nil
dic_dir_names.each {| dir_name |
  s = "-d #{dir_path}#{dir_name}"
  mecab =MeCab::Tagger.new(s)
  puts "===========", mecab.parse( "私は日本人です。")
}

n = mecab.parseToNode("私は日本人です。")
 
 word_array = []
begin
    n = n.next
    if /^名詞/ =~ n.feature
        word_array << n.surface
    end
    #puts n.feature
end until n.next.feature.include?("BOS/EOS")

puts word_array