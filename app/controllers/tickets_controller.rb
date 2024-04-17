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
    split_email_or_phone(@ticket)

    if @ticket.save
      flash[:success] = 'Ticket was successfully created.'
      redirect_to root_path
    else
      flash[:error] = 'Ticket creation failed.'
      render :index
    end
  end

  def status
    @status_text = nil
    if params[:order_number].present?
      ticket = Ticket.find_by(order_number: params[:order_number])
      @status_color = "black"
      if ticket
        @status_text = "Your order status is: #{ticket.status}"
      else
        @status_text = "Order not found. Please check your order number."
      end
      if ticket.status == "Received"
        @status_color = "red"
      elsif ticket.status == "In Progress"
        @status_color = "#c4b047" # Yellow
      elsif ticket.status == "Ready to Return"
        @status_color = "green"
      elsif ticket.status == "Resolved"
        @status_color = "blue"
      else
        @status_color = "black"
      end
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:email, :phone, :description)
  end

  def split_email_or_phone(ticket)
    email_or_phone = ticket_params[:email_or_phone]
    if email_or_phone.present?
      if email_or_phone.include?('@')
        ticket.email = email_or_phone
      else
        ticket.phone = email_or_phone
      end
    end
  end
end