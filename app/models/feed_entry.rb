class FeedEntry < ActiveRecord::Base
  def search(search)
    where('name LIKE ?', search)
  end
end