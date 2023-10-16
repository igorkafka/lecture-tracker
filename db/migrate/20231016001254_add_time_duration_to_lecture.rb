class AddTimeDurationToLecture < ActiveRecord::Migration[7.0]
  def change
    add_column :lectures, :time_duration, :datetime
  end
end
