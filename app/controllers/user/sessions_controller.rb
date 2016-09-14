class User::SessionsController < Devise::SessionsController

  respond_to :js, only: [:new, :create]

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate(auth_options)
    if self.resource
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      @resource = resource_class.new(sign_in_params).tap { |r| r.errors.add(:base, 'Invalid email/password') }
      render :new
    end
  end

end
