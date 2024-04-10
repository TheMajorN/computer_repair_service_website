class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
    @ticket = Ticket.new
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.status = 'Received'

    if @ticket.save
      flash[:success] = 'Ticket was successfully created.'
      redirect_to root_path
    else
      flash[:error] = 'Ticket creation failed.'
      render :index
    end
  end

  def status
    @status_message = nil
    if params[:order_number].present?
      ticket = Ticket.find_by(order_number: params[:order_number])
      if ticket
        @status_message = "Your order status is: #{ticket.status}"
      else
        @status_message = "Order not found. Please check your order number."
      end
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:email_or_phone, :description)
  end
end