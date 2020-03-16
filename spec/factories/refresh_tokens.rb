# == Schema Information
#
# Table name: refresh_tokens
#
#  id         :bigint           not null, primary key
#  token      :string(255)      not null
#  expires_on :datetime         not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :refresh_token do
    token { "test_token" }
    expires_on { Time.now + 3.months }
    user

    trait :expires_on_now do
      expires_on { DateTime.now }
    end

    trait :skips_validations do
      to_create {|instance| instance.save(validate: false) }
    end
  end
end
