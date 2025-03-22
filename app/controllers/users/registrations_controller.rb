class Users::RegistrationsController < Devise::RegistrationsController

    # Override the update_resource method to skip current_password validation
    def update_resource(resource, params)

        # Call the default update method to save the user
        resource.update(params)
    end

    def create
        super do |user|
            if user.persisted?
                sign_in user
                UserMailer.welcome_email(user).deliver_later
                flash[:notice] = 'Successfully registered! Welcome'
            end
        end
    end

    def update
        super do |resource|
            if resource.errors.any?
                @user = resource
                @resource = resource
                return render 'users/show', status: :unprocessable_entity
            end
        end
    end

    def after_update_path_for(resource)
        user_path(resource)
    end
end
