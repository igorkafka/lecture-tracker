
class Lecture < ApplicationRecord
  belongs_to :track, class_name: "Track", foreign_key: "tracks_id"
  def self.parse_lectures(list_lecture)
    lectures = []
    list_lecture.each do |line|
      match_data = line.match(/^(.*?)(\d{2}min)?$/)
      if match_data
        title, duration = match_data[1].strip, match_data[2] || "N/A"
        if title =~ /\d/
          raise "Não pode haver com número no títulos das palestras"
        end
        lecture = Lecture.new(time_duration: duration, title: title)
        lectures << lecture
      end
    end
    lectures
  end

  def self.define_time_schedule_lectures(lectures, period_of_day)
    DateTime.new(2013, 6, 29, 10, 15, 30)

    base_hour = period_of_day == 'morning' ?      DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day, 9, 0, 0)    : DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day, 13, 0, 0) 
    lectures.sort_by(&:time_duration).each do |lecture|
      lecture.time_scheduled = base_hour
      base_hour = base_hour + Rational(lecture.time_duration * 60, 86400)
    end
  end
end

