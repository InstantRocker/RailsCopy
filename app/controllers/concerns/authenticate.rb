module Authenticate
  
  def authenticate_with_token!
    auth_token = request.headers["AUTH-TOKEN"]
    @current_user = User.find_by authentication_token: auth_token
    if @current_user
      return
    else
      json_response "Unauthenticated", false, {}, :unauthorized
    end
  end

end