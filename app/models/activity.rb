class Activity < ApplicationRecord
  ACTIVITY_TYPES = [
    COMMENT = 'Comment'.freeze,
    STATUS_CHANGE = 'StatusChange'.freeze
  ].freeze

  belongs_to :project

  validates :type, presence: true, inclusion: { in: ACTIVITY_TYPES }
end
