class CreateVessels < ActiveRecord::Migration[5.2]
  def change
    create_table :vessels do |t|
      t.string :name, null: false
      t.references :organization, null: false

      t.timestamps
    end
  end
end
