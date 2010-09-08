xml.instruct!
xml.coupons do
  xml.title "DailySteal"
  @coupons.each do |coupon|
    xml.coupon do
      xml.title   coupon.name
      xml.price   coupon.price
      xml.picture coupon.picture
      xml.url     coupon.url
      xml.home    coupon.home
      xml.body    coupon.description
      xml.guid    coupon.guid
      xml.published_at coupon.published
    end
  end
end