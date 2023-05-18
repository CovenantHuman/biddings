class ToDoListsController < ApplicationController
    before_action :authenticate_user!

    def show
        @to_do_list = ToDoList.visible_to(current_user.id)
                              .includes(:giver, :recipient)
                              .find_by(id: params[:id])
        @to_do_items = ToDoItem.where(to_do_list_id: @to_do_list.id)
        unless @to_do_list
            render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
            return
        end
    end
end
