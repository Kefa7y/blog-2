class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tags , uniq: true

  def tags= (tag_list)
   self.tags.clear
   tag_list.strip.split(',').each do |tag|
     self.tags.build(name: tag)
   end
  end

end
