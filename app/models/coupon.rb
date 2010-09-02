class Coupon < ActiveRecord::Base
  belongs_to :location
  accepts_nested_attributes_for :location
  
end
