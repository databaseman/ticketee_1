class Ticket < ApplicationRecord
  belongs_to :project
  validates :name, presence: true
  validates :description, length: { maximum: 1000 }
  validates :description, presence: true, length: { minimum: 10 }
end
