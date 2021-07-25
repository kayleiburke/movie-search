class MoviesController < ApplicationController
  def index
    params[:movie] ||= ""

    @movies = Movie.retrieve_results(params[:movie])
    unless @movies.size > 0
      flash[:alert] = 'Movie not found'
    end
  end

end
