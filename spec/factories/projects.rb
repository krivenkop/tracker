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
  end
end
