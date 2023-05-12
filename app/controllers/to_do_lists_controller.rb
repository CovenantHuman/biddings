class ToDoListsController < ApplicationController
    before_action :authenticate_user!

    def show
        @to_do_list = ToDoList.find(params[:id])
        # I18n.config.available_locales = [:giver, :recipient]
        # I18n.locale = current_user.id == @to_do_list.giver_id ? :giver : :recipient
    end
end
