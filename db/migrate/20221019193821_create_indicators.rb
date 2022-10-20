class CreateIndicators < ActiveRecord::Migration[7.0]
  def change
    create_table :indicators do |t|
      t.string :external_id
      t.integer :score, default: 0
      t.integer :weight, default: 0
      t.belongs_to :track
      t.timestamps
    end
  end
end
