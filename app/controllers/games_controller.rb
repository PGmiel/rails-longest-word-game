require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    @letters = params[:letters].split("")
    @user_input = params[:user_input]
    @user_input_array = @user_input.split("").map { |element| element.upcase }
    if (@user_input_array - @letters).empty?
      url = "https://wagon-dictionary.herokuapp.com/#{@user_input}"
      check_link = URI.open(url).read
      response = JSON.parse(check_link)
      @score = response["found"] ? "Perfect" : "Not a valid word"
    else
      @score = "Not valid letters"
    end
  end
end
