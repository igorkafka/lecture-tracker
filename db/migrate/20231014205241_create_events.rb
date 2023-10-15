class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.date :date_scheduled, null: false
      t.timestamps
    end
  end
end
