class RemoveFkFromLikesToUser < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :likes, :users
  end
end
