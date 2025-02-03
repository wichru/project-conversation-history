module StatusChanges
  class Processor < ApplicationService
    Result = Struct.new(:success?, :activity, :message, keyword_init: true)

    def initialize(project, new_status)
      @project = project
      @new_status = new_status
    end

    def call
      return failure("Project is already #{new_status}") if same_status?

      process_status_change
    rescue ActiveRecord::RecordInvalid => e
      failure(e.message)
    end

    private

    attr_reader :project, :new_status

    def process_status_change
      activity = project.activities.build(
        type: Activity::STATUS_CHANGE,
        from_status: project.status,
        to_status: new_status
      )

      if project.change_status!(new_status, activity)
        success(activity)
      else
        failure('Failed to change status')
      end
    end

    def same_status? = project.status == new_status
    def success(activity) = Result.new(success?: true, activity:, message: "Status changed to #{activity.to_status}")
    def failure(message) = Result.new(success?: false, message:)
  end
end
