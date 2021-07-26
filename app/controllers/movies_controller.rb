class MoviesController < ApplicationController
  before_action { flash.clear }

  def index
    params[:movie] ||= ""
    params[:page] ||= 1

    movie_results = Movie.retrieve_results(movie: params[:movie], page: params[:page])
    @movies = movie_results[:movies]

    unless @movies.size > 0
      flash[:alert] = 'Movie not found'
    end

    @movies = Kaminari.paginate_array(@movies, total_count: movie_results[:total_movies]).page(params[:page]).per(10)
    @total_movies = movie_results[:total_movies]

  end

  def show
    @movie = Movie.get_movie_data(params[:id])
    @search_term = params[:search_term]
    @page = params[:page]
  end

end
