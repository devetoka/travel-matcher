class Users::RegistrationsController < Devise::RegistrationsController

    # Override the update_resource method to skip current_password validation
    def update_resource(resource, params)
        if params.key?(:password)
            if resource.update_with_password(params)
                return true
            else
                return false
            end
        else
            # For profile update, just update the fields and skip current_password
            resource.update(params)
        end
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
                if params[:update_type].present? && params[:update_type] == 'password'
                    return render 'users/change_password', status: :unprocessable_entity
                else
                    @user.reload
                    return render 'users/edit', status: :unprocessable_entity
                end
            else
                if params[:update_type] == 'password'
                    sign_out @user
                    flash[:alert] = 'Your password has been changed successfully. Please log in again.'
                    redirect_to login_path and return
                else
                    handle_profile_picture_upload(resource, params) if params[:user][:profile_picture].present?
                end
            end
        end
    end

    def after_update_path_for(resource)
        if params[:update_type].present? && params[:update_type] == 'password'
            change_password_path(resource)
        else
            user_path(resource.username)
        end
    end

    def handle_profile_picture_upload(user, params)
        # file = params[:user][:profile_picture]
        # ext = File.extname(file.original_filename)
        # filename = "#{user.id}-#{SecureRandom.hex(8)}#{ext}"
        # FileUtils.mkdir_p(Rails.root.join("public", "uploads", "users"))
        # File.open(Rails.root.join("public", "uploads", "users", filename), "wb") do |f|
        #     f.write(file.read)
        # end
        user.profile_picture.attach(params[:user][:profile_picture])
    end
end
