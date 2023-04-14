class RemoveFkFromLikesToDiscussion < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :likes, :discussions
  end
end
