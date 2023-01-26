class UsersController < ApplicationController
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

   private

   def user_params
         params.require(:user).permit(:username, :password, :email)
   end
end
