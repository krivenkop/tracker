class Project < ApplicationRecord
  validates :title, presence: true
  validates :color, presence: true
  validates :slug, presence: true
  validates_uniqueness_of :slug, case_sensitive: true

  validate :validate_color_hex

  before_validation :generate_slug

  private
  HEX_REGEX = /^#\w{3,6}|\d{3,6}$/i

  def validate_color_hex
    pp unless HEX_REGEX === color.inspect
    unless HEX_REGEX === color
      errors.add(:color, "Color must be a valid HEX")
    end
  end

  def generate_slug
    self.slug = "#{self.title.parameterize.underscore.slice(0, 15)}_#{generate_random_nums_for_slug}"
  end

  def generate_random_nums_for_slug
    10.times.map { rand(0..9) }.join
  end
end
