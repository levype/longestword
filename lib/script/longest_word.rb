require 'open-uri'
require 'json'
require 'byebug'

def generate_grid(grid_size)
  (1..grid_size).map { ('A'..'Z').to_a.sample }
end

def in_grid?(grid, attempt)
  attempt_letters = attempt.upcase.split(//)
  attempt_letters.uniq.all? { |letter| attempt_letters.count(letter) <= grid.count(letter) }
end

def run_game(attempt, grid, start_time, end_time)
  result = {}
  result[:time] = end_time - start_time
  api_url = "http://api.wordreference.com/0.8/80143/json/enfr/#{attempt}"
  stream = open(api_url)
  data = JSON.parse(stream.read)
  if data["Error"]
    result[:translation] = nil
    result[:score] = 0
    result[:message] = "not an english word"
  else
    result[:translation] = data["term0"]["PrincipalTranslations"]["0"]["FirstTranslation"]["term"]
    if in_grid?(grid, attempt)
      result[:score] = attempt.size * 10 - result[:time]
      result[:message] = "well done"
    else
      result[:score] = 0
      result[:message] = "not in the grid"
    end
  end
  return result
end
