# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  title       :string(255)      not null
#  slug        :string(255)      not null
#  color       :string(255)      not null
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :project do
    title { "Test title" }
    description { "Test description" }
    color { "#ffffff" }

    trait :invalid_color do
      color { "#ff" }
    end

    trait :empty_title do
      title { "" }
    end

    trait :empty_color do
      color { "" }
    end

    trait :empty_attributes do
      title { "" }
      description { "" }
      color { "" }
    end

    trait :with_task do
      after :create do |project|
        create :task, project: project
      end
    end

    trait 'with_tasks' do
      after :create do |project|
        create_list :task, 3, project: project
      end
    end
  end
end
