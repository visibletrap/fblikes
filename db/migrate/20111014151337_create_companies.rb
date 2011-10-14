class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :id
      t.string :name
      t.integer :score

      t.timestamps
    end
  end
end
