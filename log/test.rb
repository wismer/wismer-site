require 'net/https'
require 'oauth2'
require 'json'
class User 
  attr_reader :token, :site
  def initialize(token)
    @site      = "https://api.github.com"
    @token     = "?access_token=#{token}"
    # @token = JSON.parse(Net::HTTP.get(URI("https://api.github.com/user?access_token=#{token}")))
  end

  def users
    ['wismer', 'clin88', 'plredmond', 'carljv'].map do |name| 
      lang_data = LangData.new(token, name)
      lang_data.stats
        {
          'user' => { 
            'name'  => name,
    # 'langs' => repos, # should return array of repo names
            'stats' => lang_data.langs # should return a hash of language stats
          }
        }
    end
  end

  def show
    users.map do |user|
      "<ul>#{user}</ul>"
    end
  end
end

class LangData 
  attr_reader :token, :name, :site
  attr_accessor :langs
  def initialize(token, name)
    @token = token
    @name  = name
    @langs = {}
    @site  = "https://api.github.com"
  end

  def pull_user_repos
    JSON.parse(Net::HTTP.get(URI(site + "/users/#{name}/repos#{token}"))).map { |p| p['name'] }
  end

  def stats
    pull_user_repos.each { |repo| json_data(repo) } if pull_user_repos.size > 0
  end

  def json_data(repo)
    JSON.parse(Net::HTTP.get(URI("https://api.github.com/repos/#{name}/#{repo}/languages#{token}"))).each do |lang, val|
      unless lang.nil? 
        langs.merge!( { lang => val } ) { |key, old, new_val| old + new_val }
      end
    end
  end
end
  # def classify_langs(lang, val)
  #   case lang
  #   when 'CoffeeScript' then languages[lang] += amt
  #   when 'Ruby'         then languages[lang] += amt
  #   when 'JavaScript'   then languages[lang] += amt
  #   else
  #     languages.merge!
  #   end
  # end
# class Tastic < Crap


# https://api.github.com/users/wismer/repos