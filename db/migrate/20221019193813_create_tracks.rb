class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.string :external_id
      t.string :track_name
      t.float :score, default: 0.0
      t.belongs_to :report
      t.timestamps
    end
  end
end
