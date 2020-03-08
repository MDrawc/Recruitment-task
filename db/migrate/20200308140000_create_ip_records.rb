class CreateIpRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :ip_records do |t|
      t.string :query
      t.string :ip
      t.string :type
      t.string :hostname
      t.string :continent_code
      t.string :continent
      t.string :country_code
      t.string :country
      t.string :region_code
      t.string :region
      t.string :city
      t.string :zip
      t.decimal :latitude
      t.decimal :longitude
      t.timestamps
      t.index ["query"], name: "index_ip_records_on_query", unique: true
    end
  end
end
