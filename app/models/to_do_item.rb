class ToDoItem < ApplicationRecord
    belongs_to :to_do_list
    validates :name, presence: true
    validates :completed, inclusion: [true, false]
end
