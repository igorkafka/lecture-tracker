class Event < ApplicationRecord
  self.per_page = 10
  validates :name, presence: true
  validates :date_scheduled, presence: true
end
