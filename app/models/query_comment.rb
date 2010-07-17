class QueryComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :query

  validates_presence_of :user_id, :query_id

  # types
  TYPE_QUERY = "query"
  TYPE_REPLY = "reply"
  TYPE_CHANGED = "changed"

  TYPES = [TYPE_QUERY, TYPE_REPLY, TYPE_CHANGED]

  # actions
  ACTION_CHANGES_MADE        = 'changes_made'
  ACTION_NO_CHANGES_REQUIRED = 'no_changes_required'
  ACTION_UNKNOWN             = 'unknown'
  ACTION_DATA_NOT_COLLECTED  = 'data_not_collected'

  ACTIONS = [ACTION_CHANGES_MADE, ACTION_NO_CHANGES_REQUIRED, ACTION_UNKNOWN,  ACTION_DATA_NOT_COLLECTED]

  def query?
    query_type == TYPE_QUERY
  end

  def reply?
    query_type == TYPE_REPLY
  end

  def changed?
    query_type == TYPE_CHANGED
  end
end
