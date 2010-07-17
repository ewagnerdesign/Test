Factory.define :audit do |a|
  a.auditable_id 1
  a.auditable_type "User"
  a.auditable_lock_version 1
  a.user_id 1
  a.user_type "Site"
  a.username "some ussername"
  a.action "create"
  a.changes "some text"
  a.version 1
  a.created_at "1/1/2010"
  a.visible true
end
