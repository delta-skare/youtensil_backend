class YelpController < ApplicationController
  def search
    puts params
    yelp = YelpAdapter.new
    response = yelp.search(params[:term],params[:location])
    render json: response
  end
end
