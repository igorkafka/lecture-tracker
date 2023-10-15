class CreateLectures < ActiveRecord::Migration[7.0]
  def change
    create_table :lectures do |t|
      t.string :title
      t.references :tracks, null: false, foreign_key: true
      t.timestamps
    end
  end
end
