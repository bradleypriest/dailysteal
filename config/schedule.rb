every 1.day, :at => '11:59 pm' do
  runner 'FeedEntry.update_from_feed("http://feed.1-day.co.nz/1-day")'
end

every 1.day, :at => '11:59 am' do
  runner 'FeedEntry.update_from_feed("http://feeds.feedburner.com/offtheback")'
end
