class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :email
      t.string :phone
      t.text :description
      t.string :order_number
      t.timestamps
    end
  end
end