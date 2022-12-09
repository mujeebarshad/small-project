class CreateEmployments < ActiveRecord::Migration[5.2]
  def change
    create_table :employments do |t|
      t.references :user
      t.references :organization
      t.references :vessel

      t.timestamps
    end
  end
end
