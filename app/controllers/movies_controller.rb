class MoviesController < ApplicationController
  before_action { flash.clear }

  def index

    params[:movie] ||= ""
    params[:page] ||= 1
    @movies = []
    @total_movies = 0
    alert = "Movie not found"

    if params[:movie] != ""
      movie_results = Movie.retrieve_results(movie: params[:movie], page: params[:page])
      @movies = movie_results[:movies]

      @movies = Kaminari.paginate_array(@movies, total_count: movie_results[:total_movies]).page(params[:page]).per(10)
      @total_movies = movie_results[:total_movies]
    else
      flash[:success] = "Please enter a movie to search for"
    end

    if @movies.size == 0 && params[:movie] != ""
      flash[:alert] = "Movie not found"
    end

  end

  def show
    @movie = Movie.get_movie_data(params[:id])
  end

end
