module Ui
  class NotificationComponent < ApplicationComponent
    NOTIFICATION_TYPES = [
      ERROR_TYPE = 'error'.freeze,
      NOTICE_TYPE = 'notice'.freeze,
      SUCCESS_TYPE = 'success'.freeze
    ].freeze

    CSS_CLASSES = {
      ERROR_TYPE => 'bg-red-50 text-red-600 border-red-200',
      NOTICE_TYPE => 'bg-blue-50 text-blue-600 border-blue-200',
      SUCCESS_TYPE => 'bg-green-50 text-green-600 border-green-200'
    }.freeze

    ICONS = {
      ERROR_TYPE => 'icons/circle_close.svg',
      SUCCESS_TYPE => 'icons/circle_check.svg',
      NOTICE_TYPE => 'icons/circle_info.svg'
    }.freeze

    def initialize(type: NOTICE_TYPE, **) = super

    private

    def icon = ICONS.fetch(type)
    def wrap_classes = CSS_CLASSES.fetch(type)
  end
end
