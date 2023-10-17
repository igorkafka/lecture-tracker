class Event < ApplicationRecord
  self.per_page = 10
  validates :name, presence: true
  validates :date_scheduled, presence: true
  has_many :tracks, class_name: "Track", foreign_key: "events_id", dependent: :destroy
  accepts_nested_attributes_for :tracks, allow_destroy: true
end
