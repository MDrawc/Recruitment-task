class ChangeNameOfQueryColumnInIpRecords < ActiveRecord::Migration[5.2]
  def change
    rename_column :ip_records, :query, :input
  end
end
