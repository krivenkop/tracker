# == Schema Information
#
# Table name: jwt_blacklist
#
#  id         :bigint           not null, primary key
#  jti        :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class JwtBlacklist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Blacklist

  self.table_name = 'jwt_blacklist'
end
