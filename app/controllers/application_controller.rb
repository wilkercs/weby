class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :check_authorization, :except => [:current_user_session, :current_user, :access_denied, :choose_layout]
 
  helper :all
  helper_method :current_user_session, :current_user, :user_not_authorized

  def choose_layout
    if current_user && !current_user.theme.empty?
      return current_user.theme
    elsif current_user && !current_user.role_ids.empty?
      role_theme = Role.find(current_user.role_ids.to_s).theme
      unless role_theme.nil? or role_theme.empty?
        return role_theme
      end
    end
    return "old"
  end

  def check_authorization
    if current_user
      if current_user.is_admin
        return true
      end
      u = User.find(current_user.id)
      unless u.roles.detect do |role|
        role.rights.detect do |right|
            right.action.split(' ').detect do |ri| 
              ri == action_name && right.controller == self.class.controller_path 
            end
          end
        end
        flash[:error] = t('access_denied')
        return false
      end
    end
  end

  def set_locale
    # I18n.load_path += Dir[ File.join(Rails.root, 'lib', 'locale', '*.{rb,yml}') ]
    locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale = locale
  end

  def access_denied
    if current_user
      flash[:error] = 'Acesso negado!'
    else
      flash[:error] = 'Tente logar primeiro!'
    end
    redirect_back_or_default login_path
  end

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
    
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
    
  def require_user
    unless current_user
      store_location
      flash[:error] = "Você deve estar logado para acessar acessar essa página"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:error] = "Você não deve estar logado para acessar essa página."
      redirect_to users_url
      return false
    end
  end
    
  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    back_url = CGI.unescape(params[:back_url].to_s)
    if !back_url.blank?
      begin
        uri = URI.parse(back_url)
        # do not redirect user to another host or to the login or register page
        if (uri.relative? || (uri.host == request.host)) && !uri.path.match(%r{/(login|account/register)})
          redirect_to(back_url)
          return
        end
      rescue URI::InvalidURIError
        # redirect to default
      end
    end
    if session[:return_to] && !session[:return_to].match(%r{/(login|user_sessions/new)}).nil?
      redirect_to(session[:return_to])
    else
      redirect_to(default)
    end
    session[:return_to] = nil
  end
end
