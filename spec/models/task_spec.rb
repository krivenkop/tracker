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
require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'should validate presence of title' do
    task = build :task, :empty_title
    task.save

    expect(task.errors.messages[:title]).not_to be_empty
  end

  it 'should generate valid slug before generate' do
    task = build :project
    task.save

    expect(task.slug).to match(
        /#{task.title.parameterize.underscore.slice(0, 15)}_\d{10}/i
    )
  end

  context '.generate_slug' do
    it 'should generate valid and unique slug' do
      task_one = build :project
      task_one.save

      task_two = build :project
      task_two.save

      expect(task_one.valid?).to eq true
      expect(task_two.valid?).to eq true

      expect(task_one.slug).not_to eq task_two.slug

      expect(task_one.slug).to match(
          /#{task_one.title.parameterize.underscore.slice(0, 15)}_\d{10}/i
      )
      expect(task_two.slug).to match(
          /#{task_two.title.parameterize.underscore.slice(0, 15)}_\d{10}/i
      )
    end
  end
end
