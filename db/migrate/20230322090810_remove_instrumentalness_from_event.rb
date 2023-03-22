class RemoveInstrumentalnessFromEvent < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :min_instrumentalness
    remove_column :events, :max_instrumentalness
  end
end
