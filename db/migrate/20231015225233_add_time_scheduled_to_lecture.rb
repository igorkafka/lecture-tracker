class AddTimeScheduledToLecture < ActiveRecord::Migration[7.0]
  def change
    add_column :lectures, :time_scheduled, :datetime
  end
end
