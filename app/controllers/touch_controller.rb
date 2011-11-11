class TouchController < ApplicationController
  def perform
    begin
      (params[:id] + "_worker").classify.constantize.enqueue
      render :text  => "OK"
    rescue e
      render :text => e.message
    end
  end
end
