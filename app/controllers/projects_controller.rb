class ProjectsController < ApplicationController
  def show
    @activity = Activity.new # Only for activity form
  end
end
