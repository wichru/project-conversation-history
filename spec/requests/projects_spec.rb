require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let(:project) { create(:project, status: :pending) }

  describe 'GET /projects/:id' do
    it 'renders the project show page' do
      get project_path(project)

      expect(response).to have_http_status(:success)
      expect(response.body).to include(project.name)
    end
  end
end
