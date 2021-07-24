class MoviesController < ApplicationController
  def index
    movies = find_movie(params[:movie])
    unless movies
      flash[:alert] = 'Movie not found'
      @movies = []
    end
    @movies = movies
  end

  def search
    movies = find_movie(params[:movie])
    unless movies
      flash[:alert] = 'Movie not found'
      return render action: :index
    end
  end

  private

  def request_api(url)
    response = Excon.get(
        url
    )
    return nil if response.status != 200
    JSON.parse(response.body)
  end

  def find_movie(name)
    if name
      # ENV.fetch('OMDB_API_KEY')
      request_api(
              "http://www.omdbapi.com/?i=tt3896198&apikey=11e15d8d&s=#{URI.encode(name)}"
      )
    else
      nil
    end
  end
end
