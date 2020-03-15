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
class RefreshToken < ApplicationRecord
  validates :token, presence: true
  validates :user_id, presence: true
  validates :expires_on, presence: true
  validate :expires_on_more_than_now

  belongs_to :user

  private

  def expires_on_more_than_now
    if expires_on.present? && expires_on < Time.now
      errors.add(:expires_on, "Expires on must be in future")
    end
  end
end
