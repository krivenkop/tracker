# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  title       :string(255)      not null
#  slug        :string(255)      not null
#  description :text(65535)
#  end_date    :datetime         not null
#  status      :string(255)      default("new")
#  priority    :string(255)      default("normal")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :task do
    title { "My title" }
    slug { "My string" }
    description { "My text" }
    end_date { "2020-03-23 19:14:14" }
    status { "new" }

    trait :empty_title do
      title { "" }
    end

    trait :empty_attributes do
      title { "" }
      description { "" }
      color { "" }
      end_date { "" }
      status { "" }
    end
  end
end
