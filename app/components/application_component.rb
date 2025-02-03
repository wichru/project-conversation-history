class ApplicationComponent < ViewComponent::Base
  include Turbo::StreamsHelper
  include Turbo::FramesHelper

  def initialize(**options)
    options.each do |key, value|
      self.class.attr_reader key
      instance_variable_set(:"@#{key}", value)
    end
    super()
  end

  def render_inline = safe_join([render_in(ActionController::Base.helpers)])
end
