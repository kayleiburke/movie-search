class Movie
  include ActiveModel::Model

  def self.attributes
    [:data, :poster, :plot, :title, :runtime, :rated, :year]
  end

  attr_accessor *self.attributes

  def initialize(data)
    if data
      Movie.attributes.each do |attr|
        instance_variable_set("@#{attr}", data[attr.capitalize.to_s])
      end
      @data = data
    end
  end

  def self.get_data(movie)
    @data = request_api(
        "http://www.omdbapi.com/?apikey=#{ENV.fetch('OMDB_API_KEY')}&i=#{URI.encode(movie["imdbID"])}"
    )
    @data
  end

  def self.retrieve_results(info={})
    movies = []
    total_movies = 0

    results = self.request_api(
        "http://www.omdbapi.com/?apikey=#{ENV.fetch('OMDB_API_KEY')}&s=#{URI.encode(info[:movie])}&page=#{info[:page]}"
    )

    if results && results["Search"]
      results["Search"].each do |result|
        movie_data = Movie.get_data(result)
        movies.push(Movie.new(movie_data))
      end

      total_movies = results["totalResults"].to_i rescue movies.size
    end

    { movies: movies, total_movies: total_movies }
  end

  def self.request_api(url)
    response = Excon.get(
        url
    )
    return nil if response.status != 200
    JSON.parse(response.body)
  end

end
