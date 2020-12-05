class UsersController < ApplicationController

  before_action :load_user, except: [:index, :new, :create]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'Изменения сохранены'
    else
      # Если не удалось по какой-то причине сохранить пользователя, то используем метод render (не redirect!),
      # который заново рисует шаблон, и название шаблона
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: 'Пользователь зарегистрирован'
    else
    # Если не удалось по какой-то причине сохранить пользователя, то используем метод render (не redirect!),
    # который заново рисует шаблон, и название шаблона
      render 'new'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build
  end

  private

  def load_user
    # ||= предотвращает 2-й запрос
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation,
      :name, :username, :avatar_url
    )
  end
end
