class User < ApplicationRecord
    has_many :given_to_do_lists, class_name: "ToDoList", inverse_of: :giver, foreign_key: :giver_id
    has_many :received_to_do_lists, class_name: "ToDoList", inverse_of: :recipient, foreign_key: :recipient_id
    validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}, uniqueness: true
    validates :password_digest, presence: true
end
