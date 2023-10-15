class AddReferencesTrackerToEvent < ActiveRecord::Migration[7.0]
  def change
    add_reference :tracks, :events, index: true
  end
end
