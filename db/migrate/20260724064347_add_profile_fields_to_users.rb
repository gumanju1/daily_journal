class AddProfileFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :bio, :text
    add_column :users, :theme_preference, :string
  end
end
