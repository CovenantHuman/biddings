class ToDoList < ApplicationRecord
    belongs_to :giver, class_name: "User", inverse_of: :given_to_do_lists
    belongs_to :recipient, class_name: "User", inverse_of: :received_to_do_lists
    has_many :to_do_items
    validates :active, presence: true
end
