class UsersController < ApplicationController

    #need to skip the before_action authorized on the users controller for the create
    skip_before_action :authorized, only: [:create]

    def create
        user = User.create(user_params)
        if user.valid?
            #add the token which can be used to verify the user in this controller
            token = encode_token(user_id: user.id)
            render json: { user: UserSerializer.new(user), jwt: token }, status: :created
        else
            render json: { error: 'failed to create user' }, status: :unprocessable_entity
        end
   end

   #render the profile method
    def profile
        render json: user
    end

   private

   def user_params
         params.require(:user).permit(:username, :password, :email)
   end
end
