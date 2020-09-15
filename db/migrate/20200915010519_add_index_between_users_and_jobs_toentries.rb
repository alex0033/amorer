class AddIndexBetweenUsersAndJobsToentries < ActiveRecord::Migration[6.0]
  def change
    add_index :entries, [:user_id, :job_id], unique: true
  end
end
