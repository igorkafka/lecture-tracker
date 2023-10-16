class AddLectureReferenceToTrack < ActiveRecord::Migration[7.0]
  def change
    add_reference :lectures, :tracks, foreign_key: true
  end
end
