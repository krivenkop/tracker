class AddProjectReferenceToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :project, index: true
  end
end
