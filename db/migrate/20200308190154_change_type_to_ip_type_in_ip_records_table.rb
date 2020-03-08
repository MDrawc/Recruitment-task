class ChangeTypeToIpTypeInIpRecordsTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :ip_records, :type, :ip_type
  end
end
