module Authenticable
	# Devise method overrides 

	def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def request
  	request
  end

  # def authenticate_with_token!
  #   render json: { errors: "Not authenticated" }, status: :unauthorized unless current_user.present?
  # end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" }, status: :unauthorized unless current_user.present?
  end

end