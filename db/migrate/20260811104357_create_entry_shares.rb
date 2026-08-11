class CreateEntryShares < ActiveRecord::Migration[8.1]
  def change
    create_table :entry_shares do |t|
      t.references :entry, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
