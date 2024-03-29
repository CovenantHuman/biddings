class ToDoList < ApplicationRecord
    belongs_to :giver, class_name: "User", inverse_of: :given_to_do_lists
    belongs_to :recipient, class_name: "User", inverse_of: :received_to_do_lists
    has_many :to_do_items
    has_one :to_do_list_invite

    scope :visible_to, -> (user_id) { where(giver_id: user_id).or(where(recipient_id: user_id)) }
end
