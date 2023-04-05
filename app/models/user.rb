class User < ApplicationRecord
    CONFIRMATION_TOKEN_EXPIRATION = 10.minutes

    before_validation :downcase_email

    has_secure_password

    has_many :given_to_do_lists, class_name: "ToDoList", inverse_of: :giver, foreign_key: :giver_id
    has_many :received_to_do_lists, class_name: "ToDoList", inverse_of: :recipient, foreign_key: :recipient_id
    validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}, uniqueness: true
    validates :password_digest, presence: true

    def confirm!
        update_columns(confirmed_at: Time.current)
    end

    def confirmed?
        confirmed_at.present?
    end

    def generate_confirmation_token
        signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_email
    end

    def unconfirmed?
        !confirmed?
    end
    
    private

    def downcase_email
        if self.email
            self.email = email.downcase.strip
        end
        # also possible to write as:
        # self.email = email&.downcase.strip
    end
end
