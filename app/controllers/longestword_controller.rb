require_relative '../../lib/script/longest_word.rb'

class LongestwordController < ApplicationController
  def game
    @grid = generate_grid(10)
    @start = Time.now
  end

  def score
    @start = params[:start]
    @attempt = params[:guess]
    @end = Time.now
    @score = run_game(@attempt, 10, @start, @end)
  end



end
