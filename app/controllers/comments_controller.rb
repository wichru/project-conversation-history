class CommentsController < ApplicationController
  before_action :set_project

  def create
    @activity = @project.activities.build(type: Activity::COMMENT, content: comment_params[:content])

    if @activity.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append(
              'activities',
              html: ActivityComponent.new(activity: @activity).render_inline
            ),
            turbo_stream.update(
              'flash',
              html: Ui::NotificationComponent.new(
                type: Ui::NotificationComponent::SUCCESS_TYPE,
                text: 'Comment created successfully'
              ).render_inline
            )
          ]
        end
        format.html { redirect_to project_path(@project), notice: 'Comment created.' }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            'flash',
            html: Ui::NotificationComponent.new(
              type: Ui::NotificationComponent::ERROR_TYPE,
              text: @activity.errors.full_messages.to_sentence
            ).render_inline
          )
        end
        format.html { redirect_to project_path(@project), alert: @activity.errors.full_messages.to_sentence }
      end
    end
  end

  private

  def comment_params = params.require(:comment).permit(:content)

  def set_project
    @project = Project.find(params[:project_id])
  end
end
