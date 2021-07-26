class Movie
  extend ApiHelper

  #TODO remove "data" attribute once code is complete (this is used for debugging)
  def self.attributes
    [:data, :poster, :plot, :title, :runtime, :rated, :year, :imdbID]
  end

  attr_accessor *self.attributes

  def initialize(data)
    if data
      Movie.attributes.each do |attr|
        val = data[attr.to_s] ? data[attr.to_s] : data[attr.capitalize.to_s]
        instance_variable_set("@#{attr}", val)
      end
      @data = data
    end
  end

  def self.get_movie_data(id)
    movie_data = request_api(
{
            i: CGI.escape(id),
            plot: "full"
        }
    )
    Movie.new(movie_data)
  end

  def self.retrieve_results(info={})
    movies = []
    total_movies = 0

    results = request_api(
  {
            s: CGI.escape(info[:movie]),
            page: info[:page]
          }
    )

    if results && results["Search"]
      results["Search"].each do |result|
        movies.push(Movie.new(result))
      end

      total_movies = results["totalResults"].to_i rescue movies.size
    end

    { movies: movies, total_movies: total_movies }
  end

end
