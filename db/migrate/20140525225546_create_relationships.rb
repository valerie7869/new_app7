class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    add_index :relationships, :follower_id
    add_index :relationships, :followed_id  
    # next line includes a composite index that enforces uniqueness of pairs 
    # of (follower_id, followed_id), so that a user can’t follow another user 
    # more than  -- 11.1
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
