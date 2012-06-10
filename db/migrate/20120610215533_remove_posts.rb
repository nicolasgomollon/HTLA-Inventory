class RemovePosts < ActiveRecord::Migration
  def up
    drop_table :posts 
  end

  def down
    create_table :posts do |t|
      t.string :name
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
