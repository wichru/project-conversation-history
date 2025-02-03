module TurboStreamResponderConcern
  extend ActiveSupport::Concern

  private

  def respond_with_turbo_stream(streams, html_options = {})
    respond_to do |format|
      format.turbo_stream { render turbo_stream: streams }
      format.html { redirect_to html_options[:redirect_to], **html_options.except(:redirect_to) }
    end
  end

  def append_activity_stream(activity)
    turbo_stream.append(
      'activities',
      html: ActivityComponent.new(activity:).render_inline
    )
  end

  def flash_stream(type:, text:)
    turbo_stream.update(
      'flash',
      html: Ui::NotificationComponent.new(
        type:,
        text:
      ).render_inline
    )
  end

  def success_flash(text)
    flash_stream(
      type: Ui::NotificationComponent::SUCCESS_TYPE,
      text:
    )
  end

  def error_flash(text)
    flash_stream(
      type: Ui::NotificationComponent::ERROR_TYPE,
      text:
    )
  end
end
