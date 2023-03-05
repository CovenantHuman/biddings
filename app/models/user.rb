class User < ApplicationRecord
    has_many :given_to_do_lists, class_name: "ToDoList", inverse_of: :giver, foreign_key: :giver_id
    has_many :received_to_do_lists, class_name: "ToDoList", inverse_of: :recipient, foreign_key: :recipient_id
end
