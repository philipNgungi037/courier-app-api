class ApplicationController < ActionController::API

    #user has access to do certain things on our application.
    before_action :authorized

    #add the encode_token method #here! since the user model is inheriting from it
    def encode_token(payload)
        JWT.encode(payload, 'my_s3cr3t')
    end


    #get the token from our header in the users controller
    def auth_header
        # { Authorization: 'Bearer <token' }
        request.headers['Authorization']
    end

    def decoded_token
        if auth_header
            token = auth_header.split(' ')[1]
            begin
                JWT.decode(token, 'my_s3cr3t', true, algorithm: 'HS256')
            rescue
                nil
            end
        end

    end

    def current_user
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def logged_in?
        !!current_user
    end

    def authorized
        if logged_in?
            true
        else
            render json: { message: 'Please log in' }, status: :unauthorized
        end
    end
end
