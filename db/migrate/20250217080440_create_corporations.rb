class CreateCorporations < ActiveRecord::Migration[7.1]
  def change
    create_table :corporations do |t|
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end
