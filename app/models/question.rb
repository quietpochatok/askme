class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: "User", optional: true

  # belongs_to :user дает валидацию на присутствие юзера ниже., поэтмоу
  # поле юзера не нужно валидировать
  validates :text, presence: true
  validates :text, length: { maximum: 255 }
end
