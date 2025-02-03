require 'rails_helper'

RSpec.describe 'StatusChanges', type: :request do
  let(:project) { create(:project, status: :pending) }

  describe 'POST /projects/:project_id/status_changes' do
    context 'when the status change is valid' do
      let(:params) { { status_change: { to_status: 'active' } } }

      it 'updates the project status and responds with a success message' do
        expect(project.status).to eq('pending')

        post project_status_changes_path(project),
             params: params,
             headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }

        project.reload
        expect(project.status).to eq('active')
        expect(response.body).to include('Status changed to active')
      end
    end

    context 'when attempting to change to the same status' do
      let(:params) { { status_change: { to_status: 'pending' } } }

      it 'does not change the status and responds with an error message' do
        post project_status_changes_path(project),
             params: params,
             headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }

        project.reload
        expect(project.status).to eq('pending')
        expect(response.body).to include('Project is already pending')
      end
    end
  end
end
