Factory.define :study_site do |s|
  s.study  {|a| a.association(:study)}
  s.site   {|a| a.association(:site)}
end
