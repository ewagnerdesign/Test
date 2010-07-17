class Admin::PoliciesController < AdminController
  def index
  end

  def set
    Settings.all.each do |s|
      name = s[0]
      Settings[name] = params[name].to_i if is_integer?(params[name])
      Settings[name] = to_bool(params[name]) if is_bool?(params[name])
    end

    flash[:notice] = "Successfully saved"
  end

  def expire_all_passwords
    #TODO write to log 
    User.all.each do |u|
      u.first_login = true
      u.save!
    end
    flash[:notice] = "All users will be asked on next login to change password."
  end
  
end
