class CreateCalculators < ActiveRecord::Migration[5.1]
  def change
    create_table :calculators do |t|
      t.integer :user_id
      t.text :title
      t.text :formula

      t.timestamps
    end
  end
end
