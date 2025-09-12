class DeviseWeb3AddTo<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def up
    change_table :<%= table_name %> do |t|
      t.string :public_address
    end

    add_index :<%= table_name %>, :public_address
  end

  def down
    change_table :<%= table_name %> do |t|
      t.remove :public_address
    end

    remove_index :<%= table_name %>, :public_address
  end
end
