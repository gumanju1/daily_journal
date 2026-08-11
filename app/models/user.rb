class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :entries, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :entry_shares, dependent: :destroy
  has_many :shared_entries, through: :entry_shares, source: :entry
end
