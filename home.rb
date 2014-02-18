require 'sinatra/base'
require 'json'
require 'oauth2'
require 'net/http'
# require 'battleship'
class CrapApp < Sinatra::Base; end

require './log/test'
require './auth'
class CrapApp
  enable :sessions

  get '/auth' do 
    client = OAuth2::Client.new(CLIENT, SECRET, :site => 'https://github.com', :authorize_url => '/login/oauth/authorize')
    redirect client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth_callback')
  end

  get '/oauth_callback' do 
    access = OAuth2::Client.new(CLIENT, SECRET, :site => 'https://github.com', :authorize_url => '/login/oauth/authorize', :token_url => '/login/oauth/access_token')
    token  = access.auth_code.get_token(params[:code], :redirect_uri => 'http://localhost:3000/oauth_callback')
    redirect to("/users?token=#{token.token}")
  end

  get '/users/:user' do 
    session[:secret]
  end


  get '/users' do 
    access = User.new(params[:token])
    access.show
  end

  post '/users' do 

  end

  link '/' do 
    '/users'
  end

  get '/battleship' do 
    TEST
    # battleship stuff here
  end

  get '/' do 
    '<h1>WHAT THE FUCK</h1>'
  end
end