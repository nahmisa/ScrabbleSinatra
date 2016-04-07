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
    @user_words = ScrabbleMultiple.new(params["words"])

    erb :score
  end

  get '/score-many' do
    erb :score_many
  end

  post '/score-many' do

    unless params["words"].nil?
      @user_words = ScrabbleMultiple.new(params["words"])
    end

    @quantity = params["quantity"].to_i

    erb :score_many
  end

  run!
end
