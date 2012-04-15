class LoggedInConstraint
  def matches?(request)
    begin #if this Authologic hasn't been init'ed yet it will break; but that means no one is logged in
      match = UserSession.find
    rescue Exception
      chicken = false
    end
  end
end
