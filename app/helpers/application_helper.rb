module ApplicationHelper
  def user_avatar(user)
    user.avatar_url.presence || asset_pack_path('media/images/avatar.jpg')
  end

  def inclination(count_question)
    first_word_form, second_word_form, third_word_form = "вопрос", "вопроса", "вопросов"

    remainder_of_division_ten = count_question % 10
    value =
        if (count_question % 100).between?(11, 14) then third_word_form
        elsif remainder_of_division_ten == 1 then first_word_form
        elsif remainder_of_division_ten.between?(2, 4) then second_word_form
        else third_word_form
        end
    "#{count_question} #{value}"
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
