class ToDoItemsController < ApplicationController
    before_action :authenticate_user!

    def create 
        @to_do_item = ToDoItem.new(create_to_do_item_params)
        if @to_do_item.save
            redirect_to to_do_list_path(params[:to_do_list_id]), notice: "To do item added!" 
        else
            redirect_to new_to_do_list_to_do_item_path(params[:to_do_list_id]), notice: "Something went wrong, please try again."
        end
    end

    def new 
        @to_do_item = ToDoItem.new
        @to_do_list = ToDoList.find(params[:to_do_list_id])
    end

    def update
        to_do_item = ToDoItem.find(params[:id])
        to_do_item[:completed] = params[:completed]
        notice = if to_do_item.save
            "Item completed!"
        else
            "Something went wrong, please try to complete that item again."
        end
        redirect_to to_do_list_path(to_do_item.to_do_list_id), notice: notice
    end

    private

    def create_to_do_item_params
        create_to_do_item_params = {}
        create_to_do_item_params[:to_do_list_id] = params[:to_do_list_id]
        create_to_do_item_params[:completed] = false
        create_to_do_item_params[:name] = params[:to_do_item][:name]
        return create_to_do_item_params
    end
end
