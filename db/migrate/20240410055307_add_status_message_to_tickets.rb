class AddStatusMessageToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :status_message, :text
  end
end