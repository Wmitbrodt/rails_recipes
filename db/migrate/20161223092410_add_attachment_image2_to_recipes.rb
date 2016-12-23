class AddAttachmentImage2ToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.attachment :image2
    end
  end

  def self.down
    remove_attachment :recipes, :image2
  end
end
