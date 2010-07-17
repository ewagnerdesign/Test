Factory.define :query do |q|
  q.comment   "Comment to field value"
  q.user { |a| a.association(:user)}
  q.form_field_value { |a| a.association(:form_field_value)}
  q.closed false
end

