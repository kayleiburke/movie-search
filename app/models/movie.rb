class Movie
  extend ApiHelper

  def self.attributes
    [:poster, :plot, :title, :runtime, :rated, :year, :imdbID]
  end

  attr_accessor *self.attributes

  def initialize(data)
    if data
      Movie.attributes.each do |attr|
        val = data[attr.to_s] ? data[attr.to_s] : data[attr.capitalize.to_s]

        if attr == :title
          val ||= "No title found"
        end

        instance_variable_set("@#{attr}", val)
      end
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

  def is_empty?
    Movie.attributes.select do |attr|
      instance_variable_get("@#{attr}") != nil unless attr == 'title'
    end.size == 0
  end

end
