class QueryCommentsController < ApplicationController
  before_filter :get_query, :except => [:index]

  helper_method :monitor?, :investigator?

  def create
    unless @query.closed?
      query_comment = @query.comments.new(:comment => params[:query_comment][:comment], :user => current_user)

      if monitor?
        query_comment.query_type = QueryComment::TYPE_QUERY
      end

      if investigator?
        query_comment.query_type = QueryComment::TYPE_REPLY
        query_comment.query_action = params[:query_comment][:query_action] if QueryComment::ACTIONS.include? params[:query_comment][:query_action]
      end
    end

    respond_to do |format|
      if @query.closed?
        flash[:notice] = 'Query is already closed.'
        format.js   { render :text => "Error", :status => 500 }
      else
        if query_comment.save!
          flash[:notice] = 'Comment was successfully added.'
          format.js { render :file => 'queries/update_status.js.rjs' }
        else
          flash[:notice] = 'There was an error saving the comment.'
          format.js { render :text => "Error", :status => 500 }
        end
      end
    end
  end

  protected

  def get_query
    @query = Query.find(params[:query_id])
  end
end
