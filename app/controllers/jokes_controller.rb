# encoding: utf-8

class JokesController < ApplicationController
  # GET /jokes
  # GET /jokes.xml
  def index
    @joke = Joke.find(params[:joke_id] || random_id)
    session[:joke_id] = @joke.id
    if session[:twitter_credentials]
      @friends = client.friends.map{|f| [f['name'], f['screen_name']] }
      @friends.sort!{|a,b| a[0] <=> b[0] }
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jokes }
    end
  end

  def update
    joke = Joke.find(params[:joke_id])
    screen_name = params[:screen_name]
    url = joke_url(joke)
    client.update("@#{screen_name} Du har fått ett Göteborgskämt! #{url}")
    flash[:message] = "Skämt skickat!"
    redirect_to root_path
  end

  # GET /jokes/1
  # GET /jokes/1.xml
  def show
    @joke = Joke.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @joke }
    end
  end

  # GET /jokes/new
  # GET /jokes/new.xml
  def new
    @joke = Joke.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @joke }
    end
  end

  # GET /jokes/1/edit
  def edit
    @joke = Joke.find(params[:id])
  end

  # POST /jokes
  # POST /jokes.xml
  def create
    @joke = Joke.new(params[:joke])

    respond_to do |format|
      if @joke.save
        format.html { redirect_to(@joke, :notice => 'Joke was successfully created.') }
        format.xml  { render :xml => @joke, :status => :created, :location => @joke }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @joke.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jokes/1
  # PUT /jokes/1.xml
  # def update
  #   @
  # 
  #   respond_to do |format|
  #     if @joke.update_attributes(params[:joke])
  #       format.html { redirect_to(@joke, :notice => 'Joke was successfully updated.') }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @joke.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /jokes/1
  # DELETE /jokes/1.xml
  def destroy
    @joke = Joke.find(params[:id])
    @joke.destroy

    respond_to do |format|
      format.html { redirect_to(jokes_url) }
      format.xml  { head :ok }
    end
  end
  
  def logout
    session.delete(:twitter_credentials)
    flash[:message] = "Du loggades ut från Twitter!"
    redirect_to :back
  end
  
  private
  def random_id
    Joke.all.map(&:id)[rand(Joke.count)]
  end
  
  def client
    @client ||= TwitterOAuth::Client.new(
      :consumer_key => AppConfig['twitter']['key'], 
      :consumer_secret => AppConfig['twitter']['secret'], 
      :token => session['twitter_credentials']['token'],
      :secret => session['twitter_credentials']['secret'])
  end
end
