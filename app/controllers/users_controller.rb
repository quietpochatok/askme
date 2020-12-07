class UsersController < ApplicationController
  before_action :find_user, except: [:index, :new, :create]

  # Проверяем, имеет ли юзер доступ к экшену, делаем это для всех действий, кроме
  # :index, :new, :create, :show — к ним есть доступ у всех, даже у анонимных юзеров.
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    # Если юзер залогинен, отправляем его на главную с сообщением
    redirect_to root_path, alert: 'Вы уже залогинены' if current_user.present?

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
    # Если юзер залогинен, отправляем его на главную с сообщением
    redirect_to root_path, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: 'Пользователь зарегистрирован'
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

  def authorize_user
    reject_user unless @user == current_user
  end

  def find_user
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
