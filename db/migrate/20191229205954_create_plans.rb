class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.integer :user_id
      t.date :start_date
      t.date :end_date
      t.float :income
      t.float :fixed_ex
      t.float :target_sa
      t.float :old_savings

      t.timestamps
    end
  end
end
