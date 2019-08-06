class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    create_table :active_storage_blobs do |table|
      table.string   :key,        null: false
      table.string   :filename,   null: false
      table.bigint   :byte_size,  null: false
      table.string   :checksum,   null: false

      table.index [ :key ], unique: true
    end

    create_table :active_storage_attachments do |table|
      table.string     :name,     null: false
      table.references :record,   null: false, polymorphic: true, index: false
      table.references :blob,     null: false

      table.index [ :name, :blob_id ], name: "index_active_storage_attachments_uniqueness", unique: true
      table.foreign_key :active_storage_blobs, column: :blob_id
    end
  end
end
