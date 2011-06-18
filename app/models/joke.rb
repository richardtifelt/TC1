class Joke < ActiveRecord::Base
  def self.random_id
    order("random()").first
  end
end
