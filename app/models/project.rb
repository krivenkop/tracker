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
class Project < ApplicationRecord
  include ActiveModel::Serializers::JSON
  include SlugHelper

  has_and_belongs_to_many :users

  validates :title, presence: true
  validates :color, presence: true
  validates :slug, presence: true
  validates_uniqueness_of :slug, case_sensitive: true

  validate :validate_color_hex

  before_validation :generate_slug

  def attributes
    {title: nil, description: nil, slug: nil, color: nil}
  end

  private
  HEX_REGEX = /^#\w{3,6}|\d{3,6}$/i

  def validate_color_hex
    unless HEX_REGEX === color
      errors.add(:color, "Color must be a valid HEX")
    end
  end
end
