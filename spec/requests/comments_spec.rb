require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:project) { create(:project) }

  describe 'POST /projects/:project_id/comments' do
    context 'with valid parameters' do
      let(:valid_params) { { comment: { content: Faker::Lorem.paragraph } } }

      it 'creates a new comment and responds with a success message' do
        expect do
          post project_comments_path(project),
               params: valid_params,
               headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
        end.to change(project.activities, :count).by(1)

        expect(response.body).to include('Comment created successfully')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { comment: { content: '' } } }

      it 'does not create a comment and responds with an error message' do
        expect do
          post project_comments_path(project),
               params: invalid_params,
               headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
        end.not_to change(project.activities, :count)

        expect(response.body).to include("can't be blank")
      end
    end
  end
end
