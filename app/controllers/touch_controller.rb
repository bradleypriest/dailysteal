class TouchController < ApplicationController
  def perform
    begin
      (params[:id] + "_worker").classify.constantize.new.perform
      render :text  => "OK"
    rescue e
      render :text => e.message
    end
  end
end
