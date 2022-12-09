class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.references :account_owner, references: :users
      t.timestamps
    end
  end
end
