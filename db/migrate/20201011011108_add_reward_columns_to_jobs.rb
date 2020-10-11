class AddRewardColumnsToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :reward_type, :integer
    add_column :jobs, :reward_min_amount, :integer
    add_column :jobs, :reward_max_amount, :integer
  end
end
