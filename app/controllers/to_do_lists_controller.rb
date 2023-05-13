class ToDoListsController < ApplicationController
    before_action :authenticate_user!

    def show
        @to_do_list = ToDoList.find_by(id: params[:id])
        unless @to_do_list.present? && (current_user.id == @to_do_list.giver_id || current_user.id == @to_do_list.recipient_id)
            render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
            return
        end
    end
end
