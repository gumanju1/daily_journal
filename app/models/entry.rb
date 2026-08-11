class Entry < ApplicationRecord
  belongs_to :user

  has_one_attached :photo

  has_many :comments, dependent: :destroy
  has_many :entry_shares, dependent: :destroy
  has_many :shared_users, through: :entry_shares, source: :user

  validates :title,
            presence: true,
            length: { minimum: 3, maximum: 100 }

  validates :content,
            presence: true,
            length: { minimum: 10 }

  validates :mood, presence: true
end
