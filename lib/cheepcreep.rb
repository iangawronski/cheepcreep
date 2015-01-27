require "cheepcreep/version"
require "cheepcreep/init_db"
require "httparty"
require "pry"

module Cheepcreep
  class CreateGithubUser < ActiveRecord::Base
  end
end

class Github
  include HTTParty
  base_uri 'https://api.github.com'

  def initialize
    # ENV["FOO"] is like echo $FOO
    @auth = {:username => ENV['GITHUB_USER'], :password => ENV['GITHUB_PASS']}
  end

  def get_user(screen_name, options = {})
    options.merge!({:basic_auth => @auth})
    result = self.class.get("/users/#{screen_name}", options)
    json = JSON.parse(result.body)
  end

  def get_followers(screen_name, options = {})
    options.merge!({:basic_auth => @auth})
    result = self.class.get("/users/#{screen_name}/followers", options)
    json = JSON.parse(result.body)
    #binding.pry
    followers_array = []
    result.sample(20).each do |x|
      followers_array << get_user(x['login'])
    end
    return followers_array
  end

  # def get_gists(screen_name)
  #   result = self.class.get("/users/#{screen_name}/gists")
  #   json = JSON.parse(result.body)
  #   binding.pry
  # end

end

#binding.pry

class CheepcreepApp
  def store_user_information(screen_name)
    Cheepcreep::GithubUser.create(login: screen_name["login"], name: screen_name["name"], blog: screen_name["blog"], public_repos: screen_name["public_repos"].to_i, followers: screen_name["followers"].to_i, following: screen_name["following"].to_i)
  end
end

#binding.pry

# creeper = CheepcreepApp.new
# creeper.creep



github = Github.new
binding.pry
# resp = github.get

# @auth = {username: u, :password p}
