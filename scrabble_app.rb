require 'sinatra'
require_relative 'lib/scrabble_score'
require_relative 'lib/multiple_scrabble_score'

class ScrabbleScore < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/score' do
    erb :score
  end

  post '/score' do
    # project specs: only score-many will be able to select bonus/no bonus
    @user_input = ScrabbleMultiple.new(params["words"], "true")

    erb :score
  end

  get '/score-many' do
    erb :score_many
  end

  post '/score-many' do

    unless params["words"].nil?
      @user_input = ScrabbleMultiple.new(params["words"], params["bonus"])
    end

    @quantity = params["quantity"].to_i

    erb :score_many
  end

  run!
end
