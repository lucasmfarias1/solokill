class AddParentToPosts < ActiveRecord::Migration[5.2]
  def change
    change_table :posts do |t|
      t.integer :parent_id
    end
  end
end
