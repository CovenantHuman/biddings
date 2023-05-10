module SignInHelper
    def sign_in_as(user)
        post login_url(user: {email: user.email, password: "test"})
    end
end