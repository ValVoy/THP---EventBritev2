class CheckoutController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @total = @event.price

    @session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: [ {
        price_data: {
          currency: "eur",
          product_data: { name: @event.title },
          unit_amount: @total * 100 # Stripe calcule en centimes
        },
        quantity: 1
      } ],
      mode: "payment",
      success_url: checkout_success_url + "?event_id=#{@event.id}&session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url + "?event_id=#{@event.id}",
    )
    redirect_to @session.url, allow_other_host: true
  end

  def success
    @event = Event.find(params[:event_id])
    # Une fois le paiement validé, on crée la participation
    Attendance.create(user: current_user, event: @event)
    flash[:notice] = "Félicitations ! Vous êtes inscrit à l'événement."
    redirect_to event_path(@event)
  end

  def cancel
    @event = Event.find(params[:event_id])
    flash[:alert] = "Le paiement a été annulé."
    redirect_to event_path(@event)
  end
end
