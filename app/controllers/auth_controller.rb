class AuthController < ApplicationController

  def login
    begin
    user = login_user(params[:email], params[:password])
    token = issue_token({ 'user_id': user.id })
    render json: {
      id: user.id,
      name: user.name,
      email: user.email,
      token: token }
    rescue AuthError => e
      render json: { error: e }, status: 401
    end
  end

  def currentUser
    user = current_user
    if user
      render json: { id: user.id, name: user.name, email: user.email }
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
          name: user.name,
          email: user.email,
          token: issue_token({'user_id': user.id})
        }
      rescue AuthError => e
        render json: { error: e.msg }, status: 401
      end
    else
      render json: { error: "There was an auth error" }, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
