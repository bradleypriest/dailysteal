class Coupon < ActiveRecord::Base
  belongs_to :location
  accepts_nested_attributes_for :location
  before_create :chomp_fields

  def chomp_fields
    self.name.squish
  end
end
