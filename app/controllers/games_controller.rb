require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @include = params[:ask].upcase.chars.all? { |letter| params[:ask].upcase.count(letter) <= params[:letters].count(letter) }
    if @include
      if english_word?(params[:ask])
        @result = "Your score was #{params[:ask].length}"
      else
        @result = 'not an english word'
      end
    else
      @result = 'not in the grid'
    end
  end

  def english_word?(word)
    response = URI.parse("https://dictionary.lewagon.com/#{word.capitalize}").read
    json = JSON.parse(response)
    json["found"]
  end
end
