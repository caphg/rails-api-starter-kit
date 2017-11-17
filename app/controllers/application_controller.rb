class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :exception

  def json_error(error)
    {
      error: {
        type: error.class.to_s.split('::').last,
        message: error.message
      }
    }
  end
end
