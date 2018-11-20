require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    alph = ('a'..'z').to_a
    @my_grid = []
    10.times { @my_grid << alph[rand(0..25)] }
  end

  def inc?
    bool_array = []
    word_array = params[:my_word].split("")
    word_array.each do |l|
      bool_array << (params[:my_grid].split("").include? l)
    end
    bool_array.include? false ? false : true
  end

  def score
    params[:my_word].downcase!
    url = "https://wagon-dictionary.herokuapp.com/#{params[:my_word]}"
    word_array = params[:my_word].split("")

    if !inc?
      @score = "Sorry but #{params[:my_word]} can't be build out of #{params[:my_grid]}"
    elsif JSON.parse(open(url).read)["found"]
      @score = "Sorry but #{params[:my_word]} is not an english word...dumbass..."
    else
      @score = "Congratulation ! #{params[:my_word]} is a valid english world"
    end
  end
end
