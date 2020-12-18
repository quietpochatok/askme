class QuestionsController < ApplicationController
  # before_action/before_filtr значит, что указанный в нём метод нужно вызвать перед любым из экшенов ниже.
  # Нам не нужен метод find_question перед create и new, что мы и указали с помощью параметра only.
  # Инициализируем объект вопрос для экшенов :edit, :update, :destroy
  before_action :find_question, only: [:edit, :update, :destroy]

  before_action :authorize_user, except: [:create]

  def edit
  end


  def create
    @question = Question.new(question_params)
    @question.author = current_user
    # @question.author ||= current_user.id if current_user.present?
      if check_captcha(@question) && @question.save
        redirect_to user_path(@question.user), notice: 'Вопрос задан'
      else
        render :edit
      end
  end

  # PATCH/PUT /questions/1

  def update
    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'Вопрос сохранен'
    else
      render :edit
    end
  end


  # DELETE /questions/1
  def destroy
    user = @question.user
    @question.destroy
      redirect_to user_path(user), notice: 'Вопрос удален :('
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      if current_user.present? && params[:question][:user_id].to_i == current_user.id
        params.require(:question).permit(:text, :user_id, :answer)
      else
        params.require(:question).permit(:text, :user_id)
      end
    end

    def authorize_user
      reject_user unless @question.user == current_user
    end

    def check_captcha(model)
  current_user.present? || verify_recaptcha(model: model)
end
end
