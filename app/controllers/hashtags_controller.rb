class HashtagsController < ApplicationController
  def show
    hashtags = Hashtag.with_questions.find_by!(text: params[:text])
    @questions = hashtags.questions
  end
end
