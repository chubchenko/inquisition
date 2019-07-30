class ApplicationController < ActionController::Base
  def test_injection_brakeman
    method = params[:method]
    @result = User.send(method.to_sym)
  end

  def test_fasterer
    User.sort(:name)
  end
end
