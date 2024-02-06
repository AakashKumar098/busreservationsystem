class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters ,if: :devise_controller?

    #before_action :configure_sign_in_params, if: :devise_controller?
    
    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:user_type, :password,:name])
    end


    #this is used when we want to change redirection after sign in using device in rails 
    def after_sign_in_path_for(resource)
      stored_location = session["user_return_to"]
      session["user_return_to"] = nil # Clear the stored location after using it

      stored_location || root_path # Redirect to the stored location or the root path if none is stored
    end
end
