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
class Task < ApplicationRecord
  include SlugHelper

  has_and_belongs_to_many :users

  validates :title, presence: true
  validates :slug, presence: true

  before_validation :generate_slug

  enum status: { created: 'new', in_progress: 'in_progress', finished: 'finished' }
  enum priority: { low: 'low', normal: 'normal', high: 'high' }
end
