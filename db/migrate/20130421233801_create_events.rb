class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.timestamps
      t.integer :cco_id, null: false
      t.string :name, null: false
      t.date :start, null: false
      t.date :end, null: false
      t.date :construction_start, null: false
      t.date :teardown_end, null: false
      t.boolean :active, null: false
    end

    add_index :events, :cco_id, unique: true
    add_index :events, :active
  end
end
