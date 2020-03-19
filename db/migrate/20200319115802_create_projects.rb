class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.string :color, null: false
      t.text :description

      t.timestamps
    end

    add_index :projects, :slug, unique: true

    create_table :users_projects do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
    end
  end
end
