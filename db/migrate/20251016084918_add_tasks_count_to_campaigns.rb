class AddTasksCountToCampaigns < ActiveRecord::Migration[7.1]
  def change
    add_column :campaigns, :tasks_count, :integer, default: 0, null: false
  end
end
