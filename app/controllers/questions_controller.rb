class QuestionsController < ApplicationController
  before_action :find_question, only: [ :edit, :update, :destroy]

  before_action :authorize_user, except: [:create]

  def edit
  end


  def create
    @question = Question.new(question_params)

      if @question.save
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
      params.require(:question).permit(:text, :user_id, :answer)
    end

    def authorize_user
      reject_user unless @question.user == current_user
    end
end
