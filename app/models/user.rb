class User < ApplicationRecord
  has_secure_password

  has_many :entries, dependent: :destroy
  has_many :comments, dependent: :destroy

  generates_token_for :password_reset do
    password_reset_sent_at && password_reset_sent_at > 15.minutes.ago
  end

  validates :name, presence: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :password,
            length: { minimum: 6 },
            if: -> { password.present? }
end
