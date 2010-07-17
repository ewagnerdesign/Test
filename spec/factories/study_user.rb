Factory.define :study_user do |f|
  f.study {|a| a.association(:study)}
  f.user {|a| a.association(:user)}
end
