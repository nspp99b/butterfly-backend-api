class ApplicationController < ActionController::API
  private

  def issue_token(payload)
    JWT.encode(payload, secret, algorithm)
  end

  def login_user(email, password)
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      user
    else
      raise AuthError
    end
  end

  def authorize_user!
    if !current_user.present?
      render json: {error: 'No user id present'}
    end
  end

  def current_user
    @current_user ||= User.find_by(id: token_user_id)
  end

  def token_user_id
    decoded_token.first['user_id']
  end

  def decoded_token
    if token
      begin
        JWT.decode(token, secret, true, {algorithm: algorithm})
      rescue JWT::DecodeError
        return [{}]
      end
    else
      [{}]
    end
  end

  def token
    request.headers['Authorization']
  end

  def secret
    "vunsueiluieksenkgiklsglaufhgjksghanveiiaueranvulekgh"
  end

  def algorithm
    "HS256"
  end
end

class AuthError < StandardError
  def initialize(msg="No user or invalid password")
    super
  end
end
