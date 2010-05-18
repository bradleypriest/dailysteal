every 1.day, :at => '10:23 pm' do
#1-day
  runner 'FeedEntry.update_from_feed("http://feed.1-day.co.nz/1-day")'
#Ziwi  
  runner 'FeedEntry.update_from_feed("http://pipes.yahoo.com/pipes/pipe.run?_id=0038f307a5fc7bf87d5eb31d8bb7f462&_render=rss&urlinput1=http%3A%2F%2Fwww.ziwi.co.nz%2Fone_day_deals.php")'
#Daysale
  runner 'FeedEntry.update_from_feed("http://pipes.yahoo.com/pipes/pipe.run?_id=dd6395d74f34449af130b258b43336cd&_render=rss&urlinput1=http%3A%2F%2Fwww.daysale.co.nz%2F")'
#6Shooter
  runner 'FeedEntry.update_from_feed("http://pipes.yahoo.com/pipes/pipe.run?_id=7551b7c81b8e4eed6ca5f677bf9fad0a&_render=rss&urlinput1=http%3A%2F%2Fwww.6shooter.co.nz")'
#Catchoftheday
  runner 'FeedEntry.update_from_feed("http://pipes.yahoo.com/pipes/pipe.run?_id=0f0936783e6023eae277b075bdcee0d3&_render=rss&urlinput1=http%3A%2F%2Fwww.catchoftheday.co.nz%2F")'
#3deals
  runner 'FeedEntry.update_from_feed("http://pipes.yahoo.com/pipes/pipe.run?_id=4dbdf814e48d1d3a1c5704848dafb34d&_render=rss&urlinput1=http%3A%2F%2Fwww.3deals.co.nz%2Fsite%2Findex.php")'
end

every 1.day, :at => '11:01 pm' do
#Snatchadeal
  runner 'FeedEntry.update_from_feed("http://pipes.yahoo.com/pipes/pipe.run?_id=b9a74f43a6f4fcfa0b398f1c4e72daa0&_render=rss&urlinput1=http%3A%2F%2Fwww.snatchadeal.co.nz%2F")'
end

every 1.day, :at => '10:01 pm' do
#MightyApe
  runner 'FeedEntry.update_from_feed("http://pipes.yahoo.com/pipes/pipe.run?_id=5e52b383e457dc4384246354943dee18&_render=rss&urlinput1=http%3A%2F%2Fwww.mightyape.co.nz%2Fdaily-deals")'
#Dealaday
  runner 'FeedEntry.update_from_feed("http://pipes.yahoo.com/pipes/pipe.run?_id=dc9edde73bea56eb0bc2904050e0b53c&_render=rss&urlinput1=http%3A%2F%2Fwww.dealaday.co.nz%2F")'
end


every 1.day, :at => '10:09 pm' do
#OffTheBack
  runner 'FeedEntry.update_from_feed("http://pipes.yahoo.com/pipes/pipe.run?_id=f8139b96a3d826d39ed45d8e2f765845&_render=rss&urlinput1=http%3A%2F%2Ffeeds.feedburner.com%2Fofftheback")'
#TheDeal??
  runner 'FeedEntry.update_from_feed("http://pipes.yahoo.com/pipes/pipe.run?_id=a32754f374426e06785e6c1bec9b3124&_render=rss&urlinput2=http%3A%2F%2Fwww.thedeal.co.nz%2F")'

end
