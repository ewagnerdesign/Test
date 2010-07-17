Factory.define :site_user do |f|
  f.site {|a| a.association(:site)}
  f.user {|a| a.association(:user)}
end
