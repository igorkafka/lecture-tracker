class AddTrack < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.string :title, null: false
      t.references :events
      t.timestamps
    end
  end
end
