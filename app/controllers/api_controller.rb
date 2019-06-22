class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  include JsonResponse
  include JsonExceptionHandler

  def amadeus_data
    lat = params[:lat].to_f
    lng = params[:lng].to_f

    amadeus = Amadeus::Client.new(
      client_id: ENV['AMADEUS_CLIENT_ID'],
      client_secret: ENV['AMADEUS_CLIENT_SECRET']
      )
    response = amadeus.reference_data.locations.airports.get(latitude: lat, longitude: lng)
    # city_code = response.data.first['iataCode']
    # response = amadeus.shopping.hotel_offers.get(cityCode: city_code)
    # response = amadeus.reference_data.locations.points_of_interest.get(latitude: lat, longitude: lng)

    json_response(response.data)
  end
end
