class User < ApplicationRecord
    CONFIRMATION_TOKEN_EXPIRATION = 10.minutes
    MAILER_FROM_EMAIL = "no-reply@example.com"
    PASSWORD_RESET_TOKEN_EXPIRATION = 10.minutes

    attr_accessor :current_password

    before_save :downcase_unconfirmed_email
    before_validation :downcase_email

    has_secure_password

    has_many :given_to_do_lists, class_name: "ToDoList", inverse_of: :giver, foreign_key: :giver_id
    has_many :received_to_do_lists, class_name: "ToDoList", inverse_of: :recipient, foreign_key: :recipient_id
    has_many :to_do_list_invites, inverse_of: :inviter, foreign_key: :inviter_id
    validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}, uniqueness: true
    validates :password_digest, presence: true
    validates :unconfirmed_email, format: {with: URI::MailTo::EMAIL_REGEXP, allow_blank: true}


    def confirm!
        if unconfirmed_or_reconfirming?
            if unconfirmed_email.present?
                return false unless update(email: unconfirmed_email, unconfirmed_email: nil)
            end
            update columns(confirmed_at: Time.current)
        else
            false
        end 
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

    def send_confirmation_email!
        confirmation_token = generate_confirmation_token
        UserMailer.confirmation(self, confirmation_token).deliver_now
    end

    def generate_password_reset_token
        signed_id expires_in: PASSWORD_RESET_TOKEN_EXPIRATION, purpose: :reset_password
    end

    def send_password_reset_email!
        password_reset_token = generate_password_reset_token
        UserMailer.password_reset(self, password_reset_token).deliver_now
    end

    def confirmable_email
        if unconfirmed_email.present?
            unconfirmed_email
        else
            email
        end    
    end

    def reconfirming?
        unconfirmed_email.present?
    end

    def unconfirmed_or_reconfirming?
        unconfirmed? || reconfirming?
    end

    private

    def downcase_email
        if self.email
            self.email = email.downcase.strip
        end
        # also possible to write as:
        # self.email = email&.downcase.strip
    end

    def downcase_unconfirmed_email
        return if unconfirmed_email.nil?
        self.unconfirmed_email = unconfirmed_email.downcase.strip
    end
end
