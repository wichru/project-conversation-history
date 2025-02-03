class StatusChangesController < ApplicationController
  include TurboStreamResponderConcern

  def create
    result = StatusChanges::Processor.call(@project, status_change_params[:to_status])

    if result.success?
      respond_with_success(result)
    else
      respond_with_error(result)
    end
  end

  private

  def status_change_params = params.require(:status_change).permit(:to_status)

  def respond_with_success(result) # rubocop:disable Metrics/MethodLength
    respond_with_turbo_stream(
      [
        append_activity_stream(result.activity),
        turbo_stream.update(
          'project_status',
          html: ProjectStatusComponent.new(project: @project).render_inline
        ),
        success_flash(result.message)
      ],
      redirect_to: project_path(@project),
      notice: result.message
    )
  end

  def respond_with_error(result)
    respond_with_turbo_stream(
      error_flash(result.message),
      redirect_to: project_path(@project),
      alert: result.message
    )
  end
end
