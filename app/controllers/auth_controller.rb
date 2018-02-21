class AuthController < ApplicationController

  def login
    u = User.find_by(email: params[:email])
    if u && u.authenticate(params[:password])
      token = issue_token({ 'user_id': u.id })
      render json: {'token': token }
    else
      render json: {'error': 'Incorrect Email or Password'}, status: 401
    end
  end

  def logout
    user = current_user
    @@all.delete_if {|u| u.id === user.id }
    render json: nil
  end

  def currentUser
    user = current_user
    if user
      render json: { id: user.id, email: user.email }
    else
      render json: nil
    end
  end

  def signup
    user = User.new(user_params)
    if user.save
      begin
        user = login_user(user_params[:email], user_params[:password])
        render json: {
          id: user.id,
          email: user.email,
          token: encode_token({'user_id': user.id})
        }
      rescue AuthError => e
        render json: { error: e.msg }, status: 401
      end
    else
      render json: nil
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
