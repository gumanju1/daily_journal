class Entry < ApplicationRecord
  belongs_to :user

  has_one_attached :photo

  has_many :comments, dependent: :destroy

  validates :title,
            presence: true,
            length: { minimum: 3, maximum: 100 }

  validates :content,
            presence: true,
            length: { minimum: 10 }

  validates :mood, presence: true
end
