class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nom, :prenom, :presentation, :vehicule_type, :vehicule_annee, :ville, :preference_discussion, :preference_cigarette, :preference_animaux, :preference_musique])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nom, :prenom, :presentation, :vehicule_type, :vehicule_annee, :ville])

  end

end
