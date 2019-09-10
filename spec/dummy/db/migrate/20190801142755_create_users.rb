class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |table|
      table.string   :name
      table.integer  :email
    end
  end
end
