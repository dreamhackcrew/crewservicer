class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.timestamps
      t.references :event, null: false
      t.datetime :published_at
      t.datetime :deleted_at
      t.string :headline, null: false
      t.text :text, null: false
      t.boolean :on_site, null: false, default: false
      t.boolean :on_info_screen, null: false, default: false
      t.integer :sort_priority, null: false, default: 0
    end

    add_index :messages, :event_id
  end
end
