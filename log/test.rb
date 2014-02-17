require 'net/https'
class Crap
  attr_accessor :user, :name
  def initialize(user)
    @user = JSON.parse(Net::HTTP.get(URI("https://api.github.com/users/#{user}/repos")))
    @name = user
  end

  def langs(repo)
    yield JSON.parse(Net::HTTP.get(URI("https://api.github.com/repos/#{name}/#{repo}/languages")))
  end

  def repos
    user.map { |key| key['name'] }
  end
end

# class Tastic < Crap


# https://api.github.com/users/wismer/repos