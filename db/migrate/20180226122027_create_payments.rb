class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
