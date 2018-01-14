class Create<%= plural_name.camelize %>Table < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= plural_name %> do |t|
      <%= migration_data -%>

      t.timestamps null: false
    end

    add_index :<%= plural_name %>, :username, unique: true
  end
end
