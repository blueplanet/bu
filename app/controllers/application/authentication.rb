module Authentication
  extend ActiveSupport::Concern
  included do |base|
    before_filter :user
  end

  private
  def user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
  end

  def login_required
    if session[:user_id]
      @user ||= User.find(session[:user_id])
    else
      session[:redirect_path] = request.path
      raise(User::UnAuthorized)
    end
  end
end
