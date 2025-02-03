module Ui
  class FlashComponent < ApplicationComponent
    TYPES = {
      'alert' => Ui::NotificationComponent::ERROR_TYPE,
      'notice' => Ui::NotificationComponent::NOTICE_TYPE,
      'success' => Ui::NotificationComponent::SUCCESS_TYPE
    }.freeze

    def cast_type(value) = TYPES.fetch(value, value)
  end
end
