class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: "User", optional: true

  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_question

  # belongs_to :user дает валидацию на присутствие юзера ниже., поэтмоу
  # поле юзера не нужно валидировать
  validates :text, presence: true
  validates :text, length: { maximum: 255 }

  # commit каждый раз при удачной транзакции
  # поэтому мы пишем on: %i[create, update] указывая что при экшенах create, update
  # after_commit :create_hashtag, on: %i[create update]
  after_save_commit :create_hashtag

  private

  def create_hashtag
    Question.hashtags = "#{text} #{answer}".downcase.scan(Hashtag::HASHTAG_REGEXP).uniq.
      map { |ht| Hashtag.find_or_create_by(text: ht.delete('#')) }
  end
end
