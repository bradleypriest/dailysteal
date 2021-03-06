class CouponsController < ApplicationController
  # GET /coupons
  # GET /coupons.xml
  def index
    if cookies[:location].nil?
      @location = 'auckland'
    else
      @location = request.cookies["location"]
    end
    set_meta_tags :title => "#{@location.capitalize}'s Best Deals",
                  :keywords => "Daily Deals, 1-day deals, daily coupons, groupy, grabone, dailydo, deals, one day, 1-day, Daily Steal",
                  :description => "The Daily Steal is New Zealand's home of best daily deals and 1 day sales. We put together a fresh collection of the NZ's best deals every day."
    @coupons = Coupon.joins(:location).order('rank').where('published > ?', Time.now-1.day).where('locations.name = ?', @location)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @coupons }
    end
  end

  def local
    @coupons = Coupon.find(
    :all,
    :joins => :location,
    :conditions => ['published > ? && locations.name = ?', (Time.now-1.day), params[:id]],
    :order => 'rank'
    )
    respond_to do |format|
      format.html # index.html.erb
      format.xml # index.xml.builder
    end
  end



  # GET /coupons/1
  # GET /coupons/1.xml
  def show
    @coupon = Coupon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @coupon }
    end
  end

  # GET /coupons/new
  # GET /coupons/new.xml
  def new
    @coupon = Coupon.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @coupon }
    end
  end

  # GET /coupons/1/edit
  def edit
    @coupon = Coupon.find(params[:id])
  end

  # POST /coupons
  # POST /coupons.xml
  def create
    @coupon = Coupon.new(params[:coupon])

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to(@coupon, :notice => 'Coupon was successfully created.') }
        format.xml  { render :xml => @coupon, :status => :created, :location => @coupon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @coupon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /coupons/1
  # PUT /coupons/1.xml
  def update
    @coupon = Coupon.find(params[:id])

    respond_to do |format|
      if @coupon.update_attributes(params[:coupon])
        format.html { redirect_to(@coupon, :notice => 'Coupon was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @coupon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.xml
  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to(coupons_url) }
      format.xml  { head :ok }
    end
  end
end
