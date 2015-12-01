class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery :except => :create
  #before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :get_user_info
  helper_method :mailbox

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end
  protected

   def after_sign_up_path_for(resource)
     '/join_classes/index'
  end

  def configure_permitted_parameters
    additional_params = [:first_name, :last_name, :sid, :major, :year, :prof_pic, :github]
    devise_parameter_sanitizer.for(:sign_up).concat(additional_params)
    devise_parameter_sanitizer.for(:account_update).concat(additional_params)
  end

end
