class AddChargingStationsToRadioOrders < ActiveRecord::Migration
  def change
    change_table :radio_orders do |t|
      t.integer :charging_stations, null: false, default: 0
      t.integer :charging_stations_picked_up, null: false, default: 0
    end
  end
end
