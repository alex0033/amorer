class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :pay
      t.text :explanation
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
