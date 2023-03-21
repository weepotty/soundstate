class RemoveLivenessAndPopularityFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :liveness, :float, null: false
    remove_column :events, :popularity, :float, null: false
  end
end
