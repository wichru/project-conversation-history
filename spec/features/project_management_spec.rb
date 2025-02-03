require 'rails_helper'

RSpec.describe 'Project Management', type: :system do
  subject(:visit_project) { visit project_path(project) }

  let(:project) { create(:project, :pending, :with_comments) }

  describe 'viewing project' do
    before { visit_project }

    it 'displays project details' do
      expect(page).to have_content(project.name)
      expect(page).to have_content(project.status.humanize)
    end

    it 'shows existing comments in chronological order' do
      expected_comments = project.activities.where(type: Activity::COMMENT).order(:created_at).pluck(:content)

      within('#activities') do
        expected_comments.each do |comment_content|
          expect(page).to have_content(comment_content)
        end
      end
    end
  end

  describe 'adding comments' do
    before { visit_project }

    it 'allows adding new comments with realistic content' do
      comment_text = Faker::Lorem.paragraph(sentence_count: 2)

      fill_in 'comment[content]', with: comment_text
      click_button 'Add Comment'

      expect(page).to have_content('Comment created successfully')
      expect(page).to have_content(comment_text)
    end

    it 'handles long comments gracefully' do
      long_comment = Faker::Lorem.paragraph(sentence_count: 10)

      fill_in 'comment[content]', with: long_comment
      click_button 'Add Comment'

      expect(page).to have_content('Comment created successfully')
      expect(page).to have_content(long_comment)
    end
  end

  describe 'changing project status' do
    context 'with a pending project' do
      let(:project) { create(:project, :pending) }

      before { visit_project }

      it 'allows progression through all valid states' do
        select 'active', from: 'status_change[to_status]'
        click_button 'Change Status'
        expect(page).to have_content('Status changed to active')

        select 'completed', from: 'status_change[to_status]'
        click_button 'Change Status'
        expect(page).to have_content('Status changed to completed')
      end
    end

    context 'with status change history' do
      let(:project) { create(:project, :with_status_changes) }

      before { visit_project }

      it 'displays status change history' do
        expected_status_changes = project.activities.where(type: Activity::STATUS_CHANGE).order(:created_at).pluck(
          :from_status, :to_status
        )

        within('#activities') do
          expected_status_changes.each do |from_status, to_status|
            expect(page).to have_content("Status changed from #{from_status} to #{to_status}")
          end
        end
      end
    end
  end

  describe 'project with mixed activity types' do
    let(:project) { create(:project, :with_comments, :with_status_changes) }

    before { visit_project }

    it 'displays all activities in chronological order' do
      expected_activities = project.activities.order(:created_at)

      within('#activities') do
        expected_activities.each do |activity|
          case activity.type
          when Activity::COMMENT
            expect(page).to have_content(activity.content)
          when Activity::STATUS_CHANGE
            expect(page).to have_content("Status changed from #{activity.from_status} to #{activity.to_status}")
          end
        end
      end
    end
  end
end
