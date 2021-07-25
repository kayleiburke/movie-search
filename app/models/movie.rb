class Movie
  include ActiveModel::Model
  attr_accessor :data

  def self.get_data(movie)
    @data = request_api(
        "http://www.omdbapi.com/?apikey=#{ENV.fetch('OMDB_API_KEY')}&i=#{URI.encode(movie["imdbID"])}"
    )
    @data
  end

  def self.retrieve_results(name)
    self.request_api(
        "http://www.omdbapi.com/?apikey=#{ENV.fetch('OMDB_API_KEY')}&s=#{URI.encode(name)}"
    )
  end

  def self.request_api(url)
    response = Excon.get(
        url
    )
    return nil if response.status != 200
    JSON.parse(response.body)
  end

end
