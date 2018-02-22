class AuthController < ApplicationController

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = issue_token({ 'user_id': user.id })
      render json: {'token': token }
    else
      render json: {'error': 'Incorrect Email or Password'}, status: 401
    end
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
      user = login(user_params[:email], user_params[:password])
      render json: {
        id: user.id,
        email: user.email,
        token: issue_token({'user_id': user.id})
      }
    else
      render json: { error: "There was an error, please try again" }, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
