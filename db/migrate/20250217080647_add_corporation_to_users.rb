class AddCorporationToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :corporation, null: true, foreign_key: true
  end
end
