class User < ApplicationRecord
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  after_create { encrypt_password }

  attr_accessor :password

  def self.authenticate(username, password)
    user = User.find_by("email = ? OR username = ?", username, username)
    user.present? && user.validate_password(password) ? user : nil
  end

  def name
    [firstname, lastname].join(" ").presence || username
  end

  def validate_password(password)
    crypted_password == encrypt(password)
  end

  def encrypt(password)
    Digest::SHA1.hexdigest("--#{password_salt}--#{password}--")
  end

  def encrypt_password
    self.password_salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{username}--")
    self.crypted_password = encrypt(password)
    self.save!
  end
end
