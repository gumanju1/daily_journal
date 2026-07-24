class CreateEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :entries do |t|
      t.string :title
      t.text :content
      t.string :mood
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
