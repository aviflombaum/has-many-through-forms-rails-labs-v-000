class Post < ActiveRecord::Base
  has_many :post_categories # all this does is add methods
  # what methods
  # #post_categories
  # #post_categories<<
  # #post_categories.delete
  # #post_category_ids=ids

  has_many :categories, through: :post_categories # all this does is add methods
  # what methods
  # #category_ids=ids

  has_many :comments
  has_many :users, through: :comments
  # accepts_nested_attributes_for :categories # what method does this add?

  def categories_attributes=(categories_hashes)
    # {"0"=>{"name"=>"new category 1"}, "1"=>{"name"=>"new category 2"}}
    # how would I create a category for each of the hashes inside categories_hashes
    categories_hashes.each do |i, category_attributes|
      # create a new category if this post doesn't already have this category
      # find or create the category regardless of whether this post has it...

      # DO NOT CREATE A CATEGORY IF IT DOESN'T NAME
      if category_attributes[:name].present?
        # But also don't add a category to a post if it already has it.
        # how do I check if this post has this category already?

        category = Category.find_or_create_by(name: category_attributes[:name])
        if !self.categories.include?(category)
          # why is this ineffecient and not ideal?
          # self.categories << category
          self.post_categories.build(:category => category)
          # I need to create a category that is already associated with this post
          # and I need to make sure that this category already doesn't exist by name.
        end
      end
    end
  end
end
