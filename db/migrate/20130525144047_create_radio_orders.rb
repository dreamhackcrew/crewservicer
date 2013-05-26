class CreateRadioOrders < ActiveRecord::Migration
  def change
    create_table :radio_orders do |t|
      t.timestamps
      t.references :event, null: false
      t.string :description, null: false
    end

    add_index :radio_orders, :event_id

    create_table :radio_loans do |t|
      t.timestamps
      t.references :radio_order, null: false
      t.string :description, null: false
      t.boolean :remote_speaker_accessory, null: false
      t.boolean :earpiece_accessory, null: false
      t.boolean :headset_accessory, null: false
      t.datetime :pickup, null: false
      t.datetime :return, null: false
      t.datetime :picked_up_at
      t.datetime :returned_at
    end

    add_index :radio_loans, :radio_order_id

    create_table :radios do |t|
      t.timestamps
      t.string :serial_number
      t.references :radio_loan
    end

    add_index :radios, :serial_number
    add_index :radios, :radio_loan_id, unique: true
  end
end
