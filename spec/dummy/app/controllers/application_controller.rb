class ApplicationController < ActionController::Base
  before_action :test_fasterer, :test_injection_brakeman

  def test_injection_brakeman
    method = params[:method]
    @result = User.send(method.to_sym)
  end

  def test_fasterer
    User.sort(:name)
    I18n.t('missing_locale')
  end
end
