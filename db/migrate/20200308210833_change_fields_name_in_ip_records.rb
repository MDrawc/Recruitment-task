class ChangeFieldsNameInIpRecords < ActiveRecord::Migration[5.2]
  def change
    rename_column :ip_records, :continent, :continent_name
    rename_column :ip_records, :country, :country_name
    rename_column :ip_records, :region, :region_name
  end
end
