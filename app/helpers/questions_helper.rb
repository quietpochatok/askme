module QuestionsHelper
  def link_hashtag_in_question(text)
    text.gsub(Hashtag::HASHTAG_REGEXP) do |ht|
      link_to ht, hashtag_path(ht.delete('#').downcase )
    end.html_safe
  end
end
