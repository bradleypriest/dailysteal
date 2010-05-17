every 1.day, :at => '12:01 pm' do
  runner 'FeedEntry.update_from("http://feed.1-day.co.nz/1-day")'
end

every 1.day, :at => '10:56 am' do
  runner 'FeedEntry.update_from_feed("http://feeds.feedburner.com/offtheback")'
end
