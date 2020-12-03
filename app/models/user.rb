require "openssl"

class User < ApplicationRecord
  REGEX_FOR_USERNAME = /\W+/
  # пар-ры для работы шифр.
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password

  has_many :questions

  validates :email, :username, presence: true, uniqueness: true
  validates :username, length: { maximum: 40 }
  validates :username, format: { with: REGEX_FOR_USERNAME }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }


  before_validation :username_downcasing!

  validates :password, presence: true, on: :create
  # validates_presence_of :password, on: :create
  # доп.поле потв-ние пароля
  validates_confirmation_of :password

  before_save :encrypt_password

  private

  def username_downcasing!
    username.downcase!
  end

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt,
          ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    # Сперва находим кандидата по email
    user = find_by(email: email)

    # Если пользователь не найден, возвращает nil
    return nil unless user.present?

    # Формируем хэш пароля из того, что передали в метод
    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )
    # Обратите внимание: сравнивается password_hash, а оригинальный пароль так
    # никогда и не сохраняется нигде. Если пароли совпали, возвращаем
    # пользователя.
    return user if user.password_hash == hashed_password

    # Иначе, возвращаем nil
    nil
  end
end
