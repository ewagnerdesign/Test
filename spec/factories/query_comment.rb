Factory.define :query_comment do |q|
  q.comment   "Comment to query"
  q.user { |a| a.association(:user)}
  q.query_type QueryComment::TYPE_QUERY
  q.query_action QueryComment::ACTION_UNKNOWN
  q.query { |a| a.association(:query)}
end

Factory.define :query_comment_reply, :parent => :query_comment do |q|
  q.query_type QueryComment::TYPE_REPLY
end