require 'net/https'
class Crap
  attr_accessor :show
  def initialize(user)
    @show = JSON.parse(Net::HTTP.get(URI("https://api.github.com/users/#{user}/repos")))
  end

  def show_data
    show
  end
end# https://api.github.com/users/wismer/repos