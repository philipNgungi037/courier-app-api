class ApplicationController < ActionController::API
    #add the encode_token method #here! since the user model is inheriting from it
    def encode_token(payload)
        JWT.encode(payload, 'my_s3cr3t')
    end
end
