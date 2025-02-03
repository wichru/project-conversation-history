FactoryBot.define do
  factory :project do
    name { Faker::App.name }
    status { Project.statuses.keys.sample }

    trait :pending do
      status { 'pending' }
    end

    trait :active do
      status { 'active' }
    end

    trait :completed do
      status { 'completed' }
    end

    trait :with_comments do
      after(:create) do |project|
        create_list(:comment, 3, project: project)
      end
    end

    trait :with_status_changes do
      after(:create) do |project|
        create_list(:status_change, 2, project: project)
      end
    end
  end
end
