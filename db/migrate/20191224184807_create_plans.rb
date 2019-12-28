class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.integer :user_id
      t.date :start_Date
      t.date :End_Date
      t.float :income
      t.float :fixed_Expenses
      t.float :target_savings
      t.float :old_savings

      t.timestamps
    end
  end
end
