module ApiHelper
  extend ActiveSupport::Concern
  require "addressable/uri"

  def request_api(params)
    uri = Addressable::URI.new
    uri.query_values = params

    response = Excon.get(
        base_api + "&#{uri.query}"
    )
    return nil if response.status != 200
    JSON.parse(response.body)
  end

  def base_api
    "http://www.omdbapi.com/?apikey=#{ENV.fetch('OMDB_API_KEY')}"
  end

end
