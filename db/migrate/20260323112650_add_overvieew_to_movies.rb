class AddOvervieewToMovies < ActiveRecord::Migration[8.1]
  def change
    add_column :movies, :overview, :text
  end
end
