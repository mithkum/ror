class BookingsController < ApplicationController

  def index
    if current_user
      @bookings = current_user.bookings
    else
      render json: {
        status: 401,
        errors: ['no such user']
      }
    end
  end

  def create
    @booking = current_user.bookings.new(booking_params)

    if @booking.save
      render json: {
        status: :created,
        booking: @booking
      }
    else
      render json: {
        status: 500,
        booking: @booking.errors.full_messages
      }
    end
  end

  def update_status
    @booking = Booking.find(params[:id])
    @booking.update(status: params[:status].to_i)

    render json: {
      status: :ok,
      booking: @booking
    }
  end

  private

  def booking_params
    params.require(:booking).permit(:doctor_id, :book_date, :timeslot)
  end
end
