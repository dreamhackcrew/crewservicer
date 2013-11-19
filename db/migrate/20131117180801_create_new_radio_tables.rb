class CreateNewRadioTables < ActiveRecord::Migration
  def change
    create_table :radio_orders do |t|
      t.timestamps
      t.references :event, null: false
      t.string :description, null: false
      t.datetime :pickup_time, null: false
      t.datetime :return_time, null: false
      t.integer :earpieces, null: false, default: 0
      t.integer :earpieces_picked_up, null: false, default: 0
      t.integer :earpieces_returned, null: false, default: 0
      t.integer :remote_speakers, null: false, default: 0
      t.integer :remote_speakers_picked_up, null: false, default: 0
      t.integer :remote_speakers_returned, null: false, default: 0
      t.integer :headsets, null: false, default: 0
      t.integer :headsets_picked_up, null: false, default: 0
      t.integer :headsets_returned, null: false, default: 0
    end

    add_index :radio_orders, :event_id

    create_table :radio_loans do |t|
      t.timestamps
      t.references :radio_order, null: false
      t.references :radio
      t.string :description, null: false
      t.datetime :picked_up_at
      t.datetime :returned_at
    end

    add_index :radio_loans, :radio_order_id
    add_index :radio_loans, :radio_id
  end
end
