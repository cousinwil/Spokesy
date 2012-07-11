module SessionsHelper
  def sign_in(person)
    cookies.permanent[:remember_token] = person.remember_token
    current_person = person
  end

  def current_person=(person)
    @current_person = person
  end

  def current_person
    @current_person ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in? #is the user signed in?
    if !current_person.nil?
      return true
    else
      return false
    end
  end
end
