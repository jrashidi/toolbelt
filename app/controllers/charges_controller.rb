class ChargesController < ApplicationController
  def new
  	@reservation = Reservation.find(current_user.reservations.last)
  end

  def create
  	@reservation = Reservation.find(current_user.reservations.last)

	@amount = @reservation.total.round_down(2) * 100

	customer = Stripe::Customer.create(
	    :email => params[:stripeEmail],
	    :source  => params[:stripeToken]
	  )

	charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :currency    => 'usd'
	  )

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	
	
	redirect_to new_charge_path
	end

end

