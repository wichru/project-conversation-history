FactoryBot.define do
  factory :activity do
    project

    factory :comment do
      type { Activity::COMMENT }
      content { Faker::Lorem.paragraph }
      author_name { Faker::Name.name }
    end

    factory :status_change do
      type { Activity::STATUS_CHANGE }
      from_status { Project.statuses.keys.sample }
      to_status { Project.statuses.keys.sample }

      after(:build) do |status_change|
        if status_change.to_status == status_change.from_status
          available_statuses = Project.statuses.keys - [status_change.from_status]
          status_change.to_status = available_statuses.sample
        end
      end
    end
  end
end
