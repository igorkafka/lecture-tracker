class Lecture < ApplicationRecord
  belongs_to :track, class_name: "Track", foreign_key: "tracks_id"
  def self.parse_lectures(list)
    lectures = []
    list.each do |item|
      time_scheduled_match = /(\d{2}:\d{2})/.match(item)
      time_scheduled = time_scheduled_match[0] if time_scheduled_match
  
      title_match = /([^\d]+)\s+\d{2}min/.match(item)
      title = title_match[1].strip if title_match
  
      time_duration_match = /(\d{2}min)/.match(item)
      time_duration_match = time_duration_match[0] if time_duration_match
  
      if time_duration_match && title && time_scheduled
        lecture = Lecture.new()
        lecture.title = title
        lecture.time_scheduled = time_scheduled
        lecture.time_duration_match = time_duration_match
        lectures << lecture
      end
      lectures
    end
  end
end
