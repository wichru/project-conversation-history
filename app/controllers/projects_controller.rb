class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @activity = Activity.new # Only for activity form
  end
end
