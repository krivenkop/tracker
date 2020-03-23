class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :description
      t.datetime :end_date, null: false
      t.string :status, default: 'new', null: true
      t.string :priority, default: 'normal', null: true

      t.timestamps
    end
  end
end
