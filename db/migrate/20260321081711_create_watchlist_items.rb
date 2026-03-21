class CreateWatchlistItems < ActiveRecord::Migration[8.1]
  def change
    create_table :watchlist_items do |t|
      t.string :status
      t.integer :rating
      t.text :comment
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
