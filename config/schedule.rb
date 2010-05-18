every 1.day, :at => '12:03 pm' do
  runner 'FeedEntry.update_from_feed("http://feed.1-day.co.nz/1-day")'
end

every 1.day, :at => '12:03 am' do
  runner 'FeedEntry.update_from_feed("http://feeds.feedburner.com/offtheback")'
end
