namespace :db do
  desc " adding jokes"  
  task :add_jokes => :environment do
    @joke = ""
    File.readlines("doc/vitsar.txt").each{ |line|
      if (!line.blank?)
        @joke << line
        next
      end
      Joke.create(:joke => @joke) unless @joke.blank?
      @joke = ""
    }
  end
end