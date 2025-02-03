class Project < ApplicationRecord
  has_many :activities, -> { order(created_at: :asc) }, dependent: :destroy

  enum status: { :pending => 0, :active => 1, :completed => 2 }

  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }
end
