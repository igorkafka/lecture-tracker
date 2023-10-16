class AddReferencesTrackerToEvent < ActiveRecord::Migration[7.0]
  def change
    add_reference :tracks, :events, foreign_key: true
  end
end
