class HomeController < ApplicationController
  def index
    @upcoming_events = Event.where("start_date >= ?", Time.current)
                            .order(start_date: :asc)
                            .limit(6)
  end
end