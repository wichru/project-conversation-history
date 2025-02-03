# frozen_string_literal: true

class ActivityComponent < ApplicationComponent
  def formatted_date(date) = date.strftime('%Y-%m-%d %H:%M:%S')
end
