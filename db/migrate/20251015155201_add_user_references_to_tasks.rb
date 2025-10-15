class AddUserReferencesToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :created_by, null: true, foreign_key: { to_table: :users }, index: { name: 'index_tasks_on_created_by_id' }
    add_reference :tasks, :assigned_to, null: true, foreign_key: { to_table: :users }, index: { name: 'index_tasks_on_assigned_to_id' }
  end
end
