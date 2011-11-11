class TouchController < ApplicationController
  def perform
    (params[:id] + "_worker").classify.constantize.enqueue rescue false
    render :text  => "OK"
  end
end
