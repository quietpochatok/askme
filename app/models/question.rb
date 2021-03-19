class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: "User", optional: true

  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_question

  # belongs_to :user дает валидацию на присутствие юзера ниже., поэтмоу
  # поле юзера не нужно валидировать
  validates :text, presence: true
  validates :text, length: { maximum: 255 }
end
