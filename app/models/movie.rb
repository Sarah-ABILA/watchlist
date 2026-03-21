class Movie < ApplicationRecord
  # Relations
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  has_many :watchlist_items, dependent: :destroy
  has_many :users, through: :watchlist_items
  has_one_attached :jacket
  # Validations (La sécurité des données)
  validates :title, presence: true, uniqueness: true
  validates :genre, presence: true
  validates :description, length: { minimum: 10, message: "doit faire au moins 10 caractères" }
end
