class Track < ApplicationRecord
    belongs_to :event, class_name: "Event", foreign_key: "events_id"
end