require 'sinatra/base'
require 'json'
# require 'battleship'
class CrapApp < Sinatra::Base; end

require './log/test'

class CrapApp
  get '/users' do 
    'asd'
  end

  get '/users/:user' do 
    data = Crap.new(params[:user])
    data.show_data.each do |some|
      "#{some}"
    end
    # data = JSON.parse(data.show)
    # data
    # JSON.parse(data.show)
    # data = redirect 'https://api.github.com/users/' + params[:user] + '/repos'
    # JSON.parse(data).to_hash
    # json = URI('https://api.github.com/' + params[:user] + '/repos')
    #request.host # ('https://api.github.com/' + params[:user] + '/repos')
    # fin = json.get(json)
    # JSON.parse(fin)

  end

  get '/battleship' do 
    # battleship stuff here
  end

  get '/' do 
    '<h1>WHAT THE FUCK</h1>'
  end
end