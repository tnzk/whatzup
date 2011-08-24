class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :name
      t.string :comment
      t.string :password2delete
      t.string :password2download
      t.integer :storage_size
      t.integer :viewed
      t.integer :downloaded

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
