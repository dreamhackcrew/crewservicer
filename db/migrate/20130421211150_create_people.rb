class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.timestamps
      t.integer :cco_id, null: false
      t.string :username, null: false
      t.boolean :administrator, null: false
      t.string :cco_access_token
      t.string :cco_access_token_secret
    end

    add_index :people, :cco_id
  end
end
