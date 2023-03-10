class MakeColumnsFromAllTablesNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
    change_column_null :to_do_lists, :active, false
    change_column_null :to_do_items, :name, false
    change_column_null :to_do_items, :completed, false
  end
end
