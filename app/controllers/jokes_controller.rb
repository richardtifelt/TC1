# encoding: utf-8

class JokesController < ApplicationController
  # GET /jokes
  # GET /jokes.xml
  def index
    @random_id = Joke.random_id
  end

  # GET /jokes/1
  # GET /jokes/1.xml
  def show
    @joke = Joke.find(params[:id])
    @random_id = Joke.random_id
    session[:joke_id] = @joke.id

    if session[:twitter_credentials]
      @friends = client.friends.map{|f| [f['name'], f['screen_name']] }
      @friends.sort!{|a,b| a[0] <=> b[0] }
    end

    respond_to do |format|
      format.html do
        if request.headers['X-PJAX']
          render :layout => false
        end
      end
      format.xml  { render :xml => @joke }
    end
  end

  def tweet
    joke = Joke.find(params[:joke_id])
    screen_name = params[:screen_name]
    url = joke_url(joke)
    client.update("@#{screen_name} You just #gotanjoke! #{url}") if Rails.env.production?
    flash[:message] = "Skämt skickat#{ " (inte)" if Rails.env.development?}!"
    redirect_to root_path
  end

  def logout
    session.delete(:twitter_credentials)
    flash[:message] = "Du loggades ut från Twitter!"
    redirect_to :back
  end

  private
  def client
    @client ||= TwitterOAuth::Client.new(
      :consumer_key => AppConfig['twitter']['key'], 
      :consumer_secret => AppConfig['twitter']['secret'], 
      :token => session['twitter_credentials']['token'],
      :secret => session['twitter_credentials']['secret'])
  end
end
