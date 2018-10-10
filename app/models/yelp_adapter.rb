class YelpAdapter
  # #Returns a parsed json object of the request

  API_HOST = "https://api.yelp.com"
  SEARCH_PATH = "/v3/businesses/search"
  BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
  AUTOCOMPLETE_PATH= "/v3/autocomplete"
  API_KEY = "4lav6hUrmN9j89slsJreuOS1LXfaY1wGDl4KGXRKVaum08JOi-iSz43ySrK-jyrHpkKqjec98LhgmSWr5Xkz48TvDVbD8VR6NueIze56xbCOV5HmiuCGC_Hoq_CzW3Yx"




  DEFAULT_BUSINESS_ID = "yelp-san-diego"
  DEFAULT_TERM = "dinner"
  DEFAULT_LOCATION = "San Diego, CA"
  SEARCH_LIMIT = 50


  def search(term, location)
    puts API_HOST
    url = "#{API_HOST}#{SEARCH_PATH}"
    params = {
      term: term,
      location: location,
      limit: SEARCH_LIMIT
    }
    response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
    puts response
    response.parse["businesses"]
  end

  def self.business_reviews(business_id)
    url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}/reviews"
    response = HTTP.auth("Bearer #{API_KEY}").get(url)
    response.parse["reviews"]
  end

  def business(business_id)
    url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"
    response = HTTP.auth("Bearer #{API_KEY}").get(url)
    response.parse
  end

  def autocomplete(text, latitude=32.786882, longitude=-117.161087)
    url="#{API_HOST}#{AUTOCOMPLETE_PATH}?text=#{text}&latitude=#{latitude}&longitude=#{longitude}"
    p(url)
    response=HTTP.auth("Bearer #{API_KEY}").get(url)
    response.parse
  end
end
