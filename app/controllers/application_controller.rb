class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    
    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(
            :sign_up, 
            keys: [:first_name, :last_name, :username]
        )
        devise_parameter_sanitizer.permit(:account_update) do |user_params|
            user_params.permit(
                :first_name,
                :last_name,
                :username,
                :profile_picture,
                :location,
                :phone_number,
                :preferred_contact_method,
                :bio,
                :password,
                :password_confirmation,
                :current_password
            )
        end
    end
end
