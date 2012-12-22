module Authentication
  extend ActiveSupport::Concern
  included do |base|
    before_filter :user
    helper_method :current_user
  end

  private
  def user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
  end

  def login_required
    if session[:user_id]
      @user = current_user
    else
      session[:redirect_path] = request.path
      raise(User::UnAuthorized)
    end
  end

  def current_user
    @_current_user ||= User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
