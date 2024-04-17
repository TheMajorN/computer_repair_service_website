module Admin
  class TicketsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin

    def index
      @tickets = Ticket.all
      @ticket = Ticket.new
    end

    def show
      @ticket = Ticket.find(params[:id])
    end

    def update
      @ticket = Ticket.find(params[:id])
      if @ticket.update(ticket_params)
        redirect_to admin_tickets_path, notice: "Status message updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
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

    private

    def check_admin
      redirect_to root_url, alert: "You are not authorized to access this section" unless current_user&.admin?
    end

    def ticket_params
      params.require(:ticket).permit(:email_or_phone, :description, :status, :status_message)
    end
  end
end