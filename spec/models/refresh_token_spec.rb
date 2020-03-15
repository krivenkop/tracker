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
require 'rails_helper'

RSpec.describe RefreshToken, type: :model do
  it { expect(subject).to validate_presence_of :user_id }
  it { expect(subject).to validate_presence_of :token }
  it { expect(subject).to validate_presence_of :expires_on }

  context '.save' do
    it 'should validate that expires on bigger than now' do
      token = build :refresh_token, :expires_on_now

      expect(token).not_to be_valid
    end
  end
end
