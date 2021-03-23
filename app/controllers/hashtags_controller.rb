class HashtagsController < ApplicationController
  def show
    @hashtags = Hashtag.find_by!(text: params[:text])
    @questions = @hashtags.questions
  end
end
