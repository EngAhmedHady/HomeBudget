class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.integer :user_id
      t.date :date
      t.float :paid
      t.boolean :type
      t.text :details

      t.timestamps
    end
  end
end
