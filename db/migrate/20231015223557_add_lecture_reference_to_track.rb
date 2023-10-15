class AddLectureReferenceToTrack < ActiveRecord::Migration[7.0]
  def change
    add_reference :lectures, :tracks, index: true
  end
end
