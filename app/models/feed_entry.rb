class FeedEntry < ActiveRecord::Base
  def self.update_from_feed(feed_url)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
  end
  
 def self.update_from_feed_continuously(feed_url, delay_interval = 10.minutes)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
    loop do
      sleep delay_interval.to_i
      feed = Feedzirra::Feed.update(feed)
      add_entries(feed.new_entries) if feed.updated?
    end
  end
  
  private
  
  def self.add_entries(entries)
    entries.each do |entry|
      
  unless exists? :name => entry.title     
    if entry.id.include? "http://www.1-day.co.nz/"
      unless exists? :name => entry.title[/[^-]+/]
        create!(
          :name         => entry.title[/[^-]+/],
          :description  => entry.summary,
          :price        => entry.title[/\$[0-9\.]+/],
          :url          => entry.id,
          :published    => entry.published,
          :picture      => 'http://www.1-day.co.nz/images/products/'+entry.id[/\w+\z/]+'_large.jpg',
          :guid         => entry.id,
          :home         => '1-day',
          :home_url     => 'http://www.1-day.co.nz/',
          :role         =>  1
        )
        end
      elsif entry.summary.include? "http://www.6shooter.co.nz/"
              create!(
              :name         => entry.title,
              :description  => entry.summary,
              :picture      => entry.summary[/.+\.jpg/],
              :price        => entry.summary[/\$\d+\.\d\d(?=<\/h2)/],
              :fullprice    => entry.summary[/\$\d+\.\d\d(?=<\/h3)/],
              :url          => entry.summary[/http:\/\/www\.6shooter\.co\.nz\/deals\/\d+/],
              :guid         => entry.id,
              :home         => '6Shooter',
              :home_url     => 'http://www.6shooter.co.nz/',
              :published    => (Time.now.hour+12)>12? Date.today+12.hours : Date.today-12.hours,
              :role         => 3
             )
             
      elsif entry.summary.include? "http://www.3deals.co.nz"         
             create!(
              :name         => entry.title,
              :description  => entry.summary,
              :picture      => entry.summary[/http:\/\/\S+\.jpg/],
              :price        => entry.summary[/\$\d+\.\d\d/],
              :fullprice    => entry.summary[/\$\d+\.\d\d(?=(!| !))/],
              :url          => entry.summary[/http:[\/\d\w.-]+.html/],
              :guid         => entry.id,
              :home         => '3deals',
              :home_url     => 'http://www.3deals.co.nz/site/index.php',
              :published    => (Time.now.hour+12)>12? Date.today+12.hours : Date.today-12.hours,
              :role         =>  4
              )
     
      elsif entry.summary.include? "http://www.snatchadeal.co.nz"         
             create!(
              :name         => entry.title,
              :description  => entry.summary,
              :picture      => entry.summary[/http:\/\/[\w._ \/-]+.(jpg|gif)/],
              :price        => entry.summary[/\s\s\$\d+\.\d\d/],
              :fullprice    => entry.summary[/\$\d+\.\d\d(?=<br)/],
              :url          => entry.summary[/http:[\/\d\w.-?]+/],
              :guid         => entry.id,
              :home         => 'Snatchadeal',
              :home_url     => 'http://www.snatchadeal.co.nz/',
              :published    => (Time.now.hour+12)>11? Date.today+11.hours : Date.today-13.hours,
              :role         =>  5
              )      
     
      elsif entry.summary.include? "http://www.dealaday.co.nz"         
            create!(
              :name         => entry.title,
              :description  => entry.summary,
              :picture      => entry.summary[/http:\/\/[\w._ \/]+.jpg/],
              :price        => entry.summary[/\$[\d,]+\.\d\d/],
              :fullprice    => entry.summary[/\$\d+\.\d\d(?=<\/h3)/],
              :url          => 'http://www.dealaday.co.nz',
              :guid         => entry.id,
              :home         => 'Dealaday',
              :home_url     => 'http://www.dealaday.co.nz/',
              :published    => (Time.now.hour+12)>10? Date.today+10.hours : Date.today-14.hours,
              :role         => 6
              )
     
      elsif entry.summary.include? "http://www.catchoftheday.co.nz"         
          create!(
              :name         => entry.title,
              :description  => entry.summary,
              :picture      => entry.summary[/http:[\w.\/][^38]+(jpg|gif)/],
              :price        => entry.summary[/\$\d+\.\d\d/],
              :fullprice    => entry.summary[/\$\d+(?=\s)/],
              :url          => 'http://www.catchoftheday.co.nz',
              :guid         => entry.id,
              :published    => (Time.now.hour+12)>12? Date.today+12.hours : Date.today-12.hours,
              :home         => 'Catchoftheday',
              :home_url     => 'http://www.catchoftheday.co.nz',
              :role         => 7
              
              )      

      elsif entry.summary.include? "http://www.thedeal.co.nz"         
          create!(
              :name         => entry.title,
              :description  => entry.summary,
              :picture      => entry.summary[/http:\/\/[\w._% \/-]+.jpg/i],
              :fullprice    => entry.summary[/\$[\d,]+\.\d\d/],
              :price        => entry.summary[/\$\d+\.\d\d(?!.+Buy)/],
              :url          => entry.summary[/http:[\/\d\w.?=-]+/],
              :guid         => entry.id,
              :published    => (Time.now.hour+12)>9? Date.today+9.hours : Date.today-15.hours,
              :home         => 'TheDeal',
              :home_url     => 'http://www.thedeal.co.nz/DailyDeals.aspx',
              :role         =>  8
                    )
                    
      elsif entry.summary.include? "http://daysale.co.nz"
          create!(
              :name         => entry.title,
              :description  => entry.summary,
              :picture      => entry.summary[/http:\/\/[\w._% \/-]+.\d\d\d\.jpg/i],
              :price        => entry.summary[/\$[\d,]+\.\d\d/],
              :fullprice    => entry.summary[/\$\d+\.\d\d(?!.+normal)/m],
              :url          => entry.summary[/http:[\/\d\w.=-]+/],
              :guid         => entry.id,
              :published    => (Time.now.hour+12)>12? Date.today+12.hours : Date.today-12.hours,
              :home         => 'Daysale',
              :home_url     => 'http://daysale.co.nz',
              :role         =>  9
                                )
    elsif entry.summary.include? "ziwi.co.nz"
           create!(
              :name         => entry.title,
              :description  => entry.summary,
              :picture      => entry.summary[/http:\/\/[\w._% \/-]+.jpg/i],
              :fullprice        => entry.summary[/\$[\d,]+\.\d\d/],
              :price    => entry.summary[/\$\d+\.\d\d(?!.+Our)/],
              :url          => 'http://www.ziwi.co.nz/one_day_deals.php',
              :guid         => entry.id,
              :published    => (Time.now.hour+12)>12? Date.today+12.hours : Date.today-12.hours,
              :home         => 'Ziwi',
              :home_url     => 'http://www.ziwi.co.nz/one_day_deals.php',
              :role         =>  10
                                      ) 
    elsif entry.summary.include? "mightyape.co.nz"
         create!(
          :name         => entry.title,
          :description  => entry.summary,
          :picture      => entry.summary[/http:\/\/media[\w._% \/-]+\/4\//],
          :price        => entry.summary[/\$[\d,]+\.\d\d/],
          :fullprice    => entry.summary[/\$\d+\.\d\d(?!.+RRP)/m],
          :url          => entry.summary[/http:[\/\d\w.=-]+/],
          :guid         => entry.id,
          :published    => (Time.now.hour+12)>10? Date.today+10.hours : Date.today-14.hours,
          :home         => 'MightyApe',
          :home_url     => 'http://www.mightyape.co.nz/daily-deals/',
          :role         =>  11
                                      )
      elsif entry.id == "http://www.offtheback.co.nz/"
        unless entry.published<(Time.now-1.day)
          create!(
          :name         => entry.title,
          :description  => entry.summary,
          :price        => entry.summary[/\$[0-9\.]+/],
          #:fullprice    => entry.summary[/\$\d+\.\d\d(?!.+normal)/],
          :url          => 'http://www.offtheback.co.nz',
          :published    => entry.published,
          :picture      => entry.summary[/http:\/\/[\w._% \/-]+.jpg/i],
          :guid         => entry.id,
          :home         => 'OffTheBack',
          :home_url     => 'http://www.offtheback.co.nz/deals',
          :role         =>  2
          )
          end
      
        else   
           create!(
            :name         => entry.title,
            :description  => entry.summary
            )
      end
    end
  end
end
end