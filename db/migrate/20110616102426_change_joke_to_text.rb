class ChangeJokeToText < ActiveRecord::Migration
  def self.up
    change_column :jokes, :joke, :text
  end

  def self.down
    change_column :jokes, :joke, :string
  end
end