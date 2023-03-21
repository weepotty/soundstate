class RemoveSpeechinessFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :speechiness, :float, null: false
  end
end
