module ApiHelper
  extend ActiveSupport::Concern

  def base_api
    "http://www.omdbapi.com/?apikey=#{ENV.fetch('OMDB_API_KEY')}"
  end
end
