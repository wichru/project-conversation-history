class Project < ApplicationRecord
  include DemoProject

  has_many :activities, -> { order(created_at: :asc) }, dependent: :destroy

  enum :status, { :pending => 0, :active => 1, :completed => 2 }

  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }

  def change_status!(new_status, activity)
    return false if status == new_status

    transaction do
      activity.save!
      update!(status: new_status)
    end

    true
  end
end
