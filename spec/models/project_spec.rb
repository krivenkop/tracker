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
require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'should validate presence of title' do
    project = build :project, :empty_title
    project.save

    expect(project.errors.messages[:title]).not_to be_empty
  end

  it 'should validate presence of title' do
    project = build :project, :empty_color
    project.save

    expect(project.errors.messages[:color]).not_to be_empty
  end

  context 'should validate color to be in HEX format' do
    context 'when color is right format' do
      subject! { build :project }

      it 'should save without errors' do
        expect(subject.save).to eq true
      end
    end

    context 'when color is not right format' do
      subject! { build :project, :invalid_color }

      it 'should not save and return color error' do
        expect(subject.save).to eq false
        expect(subject.valid?).to eq false
        expect(subject.errors.messages[:color]).not_to be_empty
      end
    end
  end

  it 'should generate valid slug before generate' do
    project = build :project
    project.save

    expect(project.slug).to match(
        /#{project.title.parameterize.underscore.slice(0, 15)}_\d{10}/i
    )
  end

  context '.generate_slug' do
    it 'should generate valid and unique slug' do
      project_one = build :project
      project_one.save

      project_two = build :project
      project_two.save

      expect(project_one.valid?).to eq true
      expect(project_two.valid?).to eq true

      expect(project_one.slug).not_to eq project_two.slug

      expect(project_one.slug).to match(
          /#{project_one.title.parameterize.underscore.slice(0, 15)}_\d{10}/i
      )
      expect(project_two.slug).to match(
          /#{project_two.title.parameterize.underscore.slice(0, 15)}_\d{10}/i
      )
    end
  end
end
