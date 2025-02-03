puts 'Clearing existing data...'
Project.destroy_all

puts 'Creating projects...'
projects = []
10.times do
  projects << Project.create!(
    name: Faker::Company.catch_phrase,
    status: Project.statuses.keys.sample
  )
end

puts 'Creating activities...'
projects.each do |project|
  rand(3..8).times do
    Activity.create!(
      type: Activity::COMMENT,
      project: project,
      author_name: Faker::Name.name,
      content: Faker::Lorem.paragraph(sentence_count: 2)
    )
  end

  previous_status = 'pending'
  rand(2..4).times do
    new_status = (Project.statuses.keys - [previous_status]).sample
    Activity.create!(
      type: Activity::STATUS_CHANGE,
      project: project,
      author_name: Faker::Name.name,
      from_status: previous_status,
      to_status: new_status
    )
    previous_status = new_status
  end
end

puts 'Done!'
