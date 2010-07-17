Factory.sequence :query_action_name do |n|
  "Query Action #{n}"
end

Factory.define :query_action do |q|
  q.name { Factory.next(:query_action_name)}
end
