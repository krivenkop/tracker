# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

# This model initially had no columns defined. If you add columns to the
# model remove the '{}' from the fixture names and add the columns immediately
# below each fixture, per the syntax in the comments below
#

FactoryBot.define do
  factory :user do
    password { '12345678' }
    password_confirmation { '12345678' }

    sequence :email do |n|
      "person#{n}@example.com"
    end

    trait :with_projects do
      after :create do |user|
        create_list :project, 3, users: [user]
      end
    end

    trait :with_project do
      after :create do |user|
        create :project, users: [user]
      end
    end

    trait :with_projects_and_tasks do
      after :create do |user|
        create_list :project, 3, :with_tasks, users: [user]
      end
    end

    trait :with_project_and_task do
      after :create do |user|
        create :project, :with_task, users: [user]
      end
    end

    trait :with_project_and_tasks do
      after :create do |user|
        create :project, :with_tasks, users: [user]
      end
    end
  end
end