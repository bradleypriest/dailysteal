every 1.day, :at => '12:01 pm' do
  runner 'FeedEntry.update_from("http://feed.1-day.co.nz/1-day")'
end
