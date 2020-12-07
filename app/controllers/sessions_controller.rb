class SessionsController < ApplicationController
  def new
  end

  def create
    # return uniq object-user from DB
    @user = User.authenticate(params[:email], params[:password])

    if @user.present?
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Вы успешно залогинились'
    else
      flash.now.alert = "Неправильный пароль бро"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Вы разлогинились! Приходите еще!'
  end
end
