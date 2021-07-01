class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :publisher
      t.integer :pub_year, default: -> { Time.now().year }
      t.integer :edition, default: 1
      t.string :isbn, null: false, limit: 13

      t.timestamps
    end
  end
end
