class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?, only: [ :index ]

  def index
    @event = Event.find(params[:event_id])
    @attendances = @event.attendances
  end

  def create
    @event = Event.find(params[:event_id])
    # Cette action est utilisée pour les événements GRATUITS
    if @event.price == 0
      @attendance = Attendance.new(event: @event, user: current_user)
      if @attendance.save
        flash[:success] = "Vous êtes inscrit gratuitement !"
        redirect_to event_path(@event)
      else
        flash[:error] = "Erreur lors de l'inscription."
        redirect_to event_path(@event)
      end
    end
  end

  private

  def is_admin?
    @event = Event.find(params[:event_id])
    unless current_user == @event.admin
      flash[:alert] = "Accès réservé à l'organisateur."
      redirect_to event_path(@event)
    end
  end
end
