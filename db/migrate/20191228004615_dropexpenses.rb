class Dropexpenses < ActiveRecord::Migration[5.1]
   def up
    drop_table :expenses
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
