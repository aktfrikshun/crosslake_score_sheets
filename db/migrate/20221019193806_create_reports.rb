class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :external_id
      t.float :score, default: 0.0
      t.belongs_to :scoring_sheet
      t.timestamps
    end
  end
end
