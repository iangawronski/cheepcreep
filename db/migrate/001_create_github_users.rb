class CreateGithubUsers < ActiveRecord::Migration
  def self.up
    create_table :user do |u|
      u.string :login, uniqueness: true
      u.string :name
      u.string :blog
      u.string :public_repos
      u.string :followers
      u.string :following
    end
  end

  def self.down
    drop_table :user
  end
end
