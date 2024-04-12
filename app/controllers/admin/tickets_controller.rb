module Admin
    class TicketsController < ApplicationController
      before_action :authenticate_user!
      before_action :check_admin
  
      def index
        @tickets = Ticket.all
      end
  
      private
  
      def check_admin
        redirect_to root_url, alert: "You are not authorized to access this section" unless current_user&.admin?
      end
    end
end