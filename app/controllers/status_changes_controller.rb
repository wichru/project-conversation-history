class StatusChangesController < ApplicationController
  before_action :set_project

  def create
    new_status = status_change_params[:to_status]

    if @project.status == new_status
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            'flash',
            html: Ui::NotificationComponent.new(
              type: Ui::NotificationComponent::ERROR_TYPE,
              text: "Project is already #{new_status.humanize}"
            ).render_inline
          )
        end
        format.html { redirect_to project_path(@project), alert: "Project is already #{new_status.humanize}" }
      end
      return
    end

    @activity = @project.activities.build(
      type: Activity::STATUS_CHANGE,
      from_status: @project.status,
      to_status: new_status
    )
    @project.status = new_status

    ActiveRecord::Base.transaction do
      @project.save!
      @activity.save!
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append(
            'activities',
            html: ActivityComponent.new(activity: @activity).render_inline
          ),
          turbo_stream.update(
            'project_status',
            html: ProjectStatusComponent.new(project: @project).render_inline
          ),
          turbo_stream.update(
            'flash',
            html: Ui::NotificationComponent.new(
              type: Ui::NotificationComponent::SUCCESS_TYPE,
              text: "Project status changed successfully to #{new_status}"
            ).render_inline
          )
        ]
      end
      format.html { redirect_to project_path(@project), notice: "Status changed to #{new_status}." }
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'flash',
          html: Ui::NotificationComponent.new(
            type: Ui::NotificationComponent::ERROR_TYPE,
            text: e.message
          ).render_inline
        )
      end
      format.html { redirect_to project_path(@project), alert: e.message }
    end
  end

  private

  def status_change_params = params.require(:status_change).permit(:to_status)

  def set_project
    @project = Project.find(params[:project_id])
  end
end
