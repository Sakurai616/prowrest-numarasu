class ApplicationController < ActionController::Base
  before_action :require_login

  add_flash_types :success, :info, :warning, :error

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to main_app.login_path #rails_admin
  end
end
