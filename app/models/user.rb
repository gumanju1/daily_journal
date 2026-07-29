class User < ApplicationRecord
  has_secure_password

  has_many :entries, dependent: :destroy

  validates :name, presence: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :password,
            length: { minimum: 6 },
            if: -> { password.present? }
end
