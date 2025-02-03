class StatusChange < Activity
  validates :from_status, presence: true
  validates :to_status, presence: true
end
