class AddAuthorToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :author, index: true
    add_foreign_key :tickets, :users, column: :author_id
  end
end

# below ensures the foreign key points to the users table
# this is instead of the tickets table pointing to the authors table
# add_foreign_key :tickets, :users, column: :author_id