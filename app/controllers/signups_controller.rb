class SignupsController < ApplicationController
  def index
    @signup = Signup.new(params[:signup])
    if request.post?
      @signup.save
      redirect_to(signup_thanks_url)
    end
  end
  def new
    @signup = Signup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @signup }
    end
  end

  # POST /signups
  # POST /signups.xml
  def create
    @signup = Signup.new(params[:signup])
    
    respond_to do |format|
      if @signup.save
        format.html { redirect_to(root_url, :notice => 'Signup was successfully created.') }
        format.xml  { render :xml => @signup, :status => :created, :location => @signup }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @signup.errors, :status => :unprocessable_entity }
      end
    end
  end
  def thanks
  end
end
