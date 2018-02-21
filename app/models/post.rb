class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tags, uniq: true

  def tags=(tag_list)
    tags.clear
    tag_list.strip.split(' ').each do |ctag|
      tag = Tag.find_by(name: ctag)
      if tag.nil?
        tags.build(name: ctag)
      else
        tags << tag unless tags.include?(tag)
      end
    end
  end
end
