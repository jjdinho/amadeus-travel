module JsonExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from NoMethodError do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    # In case of a current_user trying to access data from another
    # hotel. See 'authorize_object' method in api/v1 controller.
    rescue_from ActionController::BadRequest do |e|
      json_response({ message: e.message }, :bad_request)
    end
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
