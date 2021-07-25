class MoviesController < ApplicationController
  def index
    params[:movie] ||= ""

    movies = Movie.retrieve_results(params[:movie])
    unless movies && movies["Search"]
      flash[:alert] = 'Movie not found'
      @movies = []
    else
      @raw = movies
      @movies = movies["Search"]
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
              "http://www.omdbapi.com/?apikey=#{ENV.fetch('OMDB_API_KEY')}&s=#{URI.encode(name)}"
      )
    else
      nil
    end
  end
end
