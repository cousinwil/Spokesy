module EventsHelper

  def signed_in? #is the user signed in?
    if !current_person.nil?
      return true
    else
      return false
    end
  end

  def is_admin? #is the user an admin (or a superuser?)
    if current_person.admin
      return true
    end      
  end

end
