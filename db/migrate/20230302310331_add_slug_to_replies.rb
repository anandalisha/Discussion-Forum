class AddSlugToReplies < ActiveRecord::Migration[6.0]
  def change
    add_column :replies, :slug, :string
  end
end
