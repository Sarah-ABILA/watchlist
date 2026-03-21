class Movie < ApplicationRecord
  belongs_to :user
  has_many :watchlist_items, dependent: :destroy
  has_many :users, through: :watchlist_items
end
