puts 'Clearing database...'
Project.destroy_all
Activity.destroy_all
puts 'Seeding data...'

project = Project.first_or_create!(
  name: 'Demo Project Homey',
  status: 'pending'
)

project.activities.create!(
  type: Activity::STATUS_CHANGE,
  from_status: 'pending',
  to_status: 'active'
)
project.update!(status: 'active')

project.activities.create!(
  type: Activity::COMMENT,
  content: 'Q: Is the conversation history per project or global?'
)

project.activities.create!(
  type: Activity::COMMENT,
  content: 'A: Per project. Each project has its own conversation history.'
)

project.activities.create!(
  type: Activity::COMMENT,
  content: 'Q: What statuses are allowed for a project?'
)

project.activities.create!(
  type: Activity::COMMENT,
  content: "A: Allowed statuses are 'pending', 'active', and 'completed'."
)

project.activities.create!(
  type: Activity::COMMENT,
  content: 'Q: Should a status change record both the old and new status?'
)

project.activities.create!(
  type: Activity::COMMENT,
  content: 'A: Yes, record both the previous and new status.'
)

project.activities.create!(
  type: Activity::COMMENT,
  content: 'Q: Should notifications be shown when actions occur?'
)
project.activities.create!(
  type: Activity::COMMENT,
  content: 'A: Yes. We should show a success or error notification using our Ui::NotificationComponent.'
)

project.activities.create!(
  type: Activity::COMMENT,
  content: 'Q: Should the UI update dynamically when changes occur?'
)

project.activities.create!(
  type: Activity::COMMENT,
  content: 'A: Yes, we will use Turbo Streams so that changes are shown without a full page reload.'
)

project.activities.create!(
  type: Activity::STATUS_CHANGE,
  from_status: 'active',
  to_status: 'completed'
)
project.update!(status: 'completed')

puts "Seed data loaded for project: #{project.name} (Status: #{project.status})"
