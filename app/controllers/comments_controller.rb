class CommentsController < ApplicationController
  include TurboStreamResponderConcern

  def create # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    @activity = @project.activities.build(
      type: Activity::COMMENT,
      content: comment_params[:content]
    )

    if @activity.save
      respond_with_turbo_stream(
        [
          append_activity_stream(@activity),
          success_flash('Comment created successfully')
        ],
        redirect_to: project_path(@project),
        notice: 'Comment created successfully.'
      )
    else
      respond_with_turbo_stream(
        error_flash(@activity.errors.full_messages.to_sentence),
        redirect_to: project_path(@project),
        alert: @activity.errors.full_messages.to_sentence
      )
    end
  end

  private

  def comment_params = params.require(:comment).permit(:content)
end
