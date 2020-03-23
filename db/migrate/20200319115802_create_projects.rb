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

    create_join_table :users, :projects
  end
end
