class EditGithubUsersColumn < ActiveRecord::Migration
  def self.up
    change_column(:user, :public_repos, :integer)
    change_column(:user, :followers, :integer)
    change_column(:user, :following, :integer)
  end

  def self.down
    drop_table :user
  end
end
