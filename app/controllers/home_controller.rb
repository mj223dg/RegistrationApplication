class HomeController < ApplicationController
  def index
    10.times { puts api_events_path }
    redirect_to api_events_path
  end
end
