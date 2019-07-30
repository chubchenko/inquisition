class ApplicationController < ActionController::Base
  def test_injection
    method = params[:method]
    @result = User.send(method.to_sym)
  end
end
