class CreateBookInstances < ActiveRecord::Migration[6.1]
  def change
    create_table :book_instances do |t|
      t.references :book, null: false, foreign_key: {to_table: :books}
      t.string :shelfmark
      t.date :purchased_at
      t.references :lended_by, null: true, foreign_key: {to_table: :users}
      t.references :reserved_by, null: true, foreign_key: {to_table: :users}
      t.datetime :checkout_at, null:true
      t.date :due_at, null: true
      t.datetime :returned_at, null: true

      t.timestamps
    end
  end
end
