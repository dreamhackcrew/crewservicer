class ArchiveRadioTables < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE SCHEMA archive;
    SQL

    rename_table :radio_orders, :radio_orders_v1
    rename_table :radio_loans, :radio_loans_v1

    execute <<-SQL
      ALTER TABLE radio_orders_v1 SET SCHEMA archive;
    SQL

    execute <<-SQL
      ALTER TABLE radio_loans_v1 SET SCHEMA archive;
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE archive.radio_orders_v1 SET SCHEMA public;
    SQL

    execute <<-SQL
      ALTER TABLE archive.radio_loans_v1 SET SCHEMA public;
    SQL

    rename_table :radio_orders_v1, :radio_orders
    rename_table :radio_loans_v1, :radio_loans

    execute <<-SQL
      DROP SCHEMA archive;
    SQL
  end
end
