class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :set_project

  private

  def params_id = params[:id] || params[:project_id]

  def set_project
    @project = params_id ? Project.find(params_id) : Project.demo
  end
end
