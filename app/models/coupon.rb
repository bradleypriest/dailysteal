class Coupon < ActiveRecord::Base
  named_scope :grabone, :conditions => {:home => 1}
  named_scope :first, :first
end
