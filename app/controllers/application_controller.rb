# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  SSL_ENVIRONMENTS = Set['production']

  helper :all # include all helpers, all the time

  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user, :monitor?, :investigator?

  cattr_accessor :hashed_query

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '4740cf7609fc944d9cd6007e055c15b5'

  ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
        :default => Proc.new { |x| x.strftime('%d-%b-%Y').upcase },
        :date_time12 => Proc.new { |x| x.strftime('%d-%b-%Y %I:%M%p').upcase },
        :date_time24 => Proc.new { |x| x.strftime('%d-%b-%Y %H:%M').upcase },
        :date_time24s => Proc.new { |x| x.strftime('%d-%b-%Y %H:%M:%S').upcase }
  )




  before_filter :require_ssl, :require_user, :jquery_noconflict, :set_user_timezone

  def set_user_timezone
    Time.zone = current_user.time_zone unless current_user.nil?
  end

  def jquery_noconflict
    ActionView::Helpers::PrototypeHelper.const_set(:JQUERY_VAR, 'jQuery') unless ActionView::Helpers::PrototypeHelper.const_defined?(:JQUERY_VAR)
  end

  def get_current_search(model, current_query = nil, prefix = nil)
    fields = model::SEARCH_FIELDS
    fields = Array.new(fields).collect! {|x| prefix + "_" + x.to_s } if prefix
    {fields.join("_or_") + "_like_any" => prepare_query(current_query ? current_query : @current_query)}
  end

  # === Parameters
  # :prefix =>
  # :current_query =>
  # :query_key => key symbol in @current_query hash
  # :model => model class
  def get_current_search_hash(options = {})
    fields = (options[:model] || controller_name.classify.constantize)::SEARCH_FIELDS
    fields = Array.new(fields).collect! {|x| options[:prefix] + "_" + x.to_s } if options[:prefix]
    if self.class.hashed_query
      query_string = @current_query[:query]
    else
      query_string = @current_query
    end
    @search_params = {fields.join("_or_") + "_like_any" => prepare_query(options[:current_query] || query_string)}
  end

  def get_current_search_condition_hash(options = {})
    @search_condition_params = {}
    return @search_condition_params unless self.class.hashed_query
    field_mapping = (options[:model] || controller_name.classify.constantize)::SEARCH_CONDITIONS || []
    field_mapping.each {|k,v| @search_condition_params[v] = @current_query[k]}
    @search_condition_params
  end


  def get_current_query_session_name(parent_entity, c_name)
    "#{c_name}_current_query_#{parent_entity.nil? ? '' : parent_entity.id}".to_sym
  end

  # Proxy current search query for any of the controllers by storing it in a session.
  def set_current_query(parent_entity = nil)
    if params[:cache_search_query] != "false"
      if params[@template.dom_id_nested(:commit, parent_entity)] != "Clear" #see _filter_form.erb file
        query = params[:search] || get_current_query(parent_entity)
      end
      @current_query = session[get_current_query_session_name(parent_entity, controller_name)] = query
    else
      @current_query = params[:search] || ""
    end
  end

  def get_current_query(parent_entity = nil, c_name = nil)
    @current_query = session[get_current_query_session_name(parent_entity, c_name.blank? ? controller_name : c_name)] || ""
  end

  # check and prepare @current_query
  def check_current_query_parent
    @current_query = {} unless @current_query.is_a?(Hash)
    @current_query[:query] = "" unless @current_query[:query].is_a?(String)
    # convert "false" (string) to false (bool)
    inc = @current_query[:inc_children]
    @current_query[:inc_children] = (inc.nil? || inc == "false") ? false : true if !inc.is_a?(FalseClass) && !inc.is_a?(TrueClass)
    # save converted value back to session. Useful for child controller
    session[get_current_query_session_name(nil, controller_name)] = @current_query
  end

  def prepare_query(query)
    query.blank? ? "" : query.gsub(/%/, "\\%")
  end

  # Adds filters for managing search queries in controller methods.
  # === Parameters
  # * +methods+ = hash with :get and :set keys containg corresponding controller methods for
  #   get_current_query and _set_current_query accordingly
  def self.add_query_filters(methods = {})
    before_filter :get_current_query, :only => methods[:get] || [:show, :new, :create, :edit, :update]
    before_filter :set_current_query, :only => methods[:set] || [:index]
  end

  # treat @current_query as a hash
  # === Parameters
  # * :methods - array of methods to call process_query_hash before
  def self.use_hashed_query(methods = nil, &block)
    before_filter :process_query_hash, :only => methods || [:index, :show, :new, :create, :edit, :update]
    self.hashed_query = true
    define_method :process_query_hash do
      @current_query = {} unless @current_query.is_a?(Hash)
      block.call(@current_query) if block_given?
    end
  end


  #temporary solution to distinguish monitor and investigator
  def monitor?
    current_user.try(:login) == 'monitor'
  end

  def investigator?
    current_user.try(:login) == 'investigator'
  end

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default, format = nil)
    case format
      when :html : session[:return_to] = session[:return_to].gsub(/\.js[$\/]?/, '/').gsub(/\.js\?/, '?') if session[:return_to]
    end

    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def require_ssl
    return unless SSL_ENVIRONMENTS.include?(Rails.env)

    unless (request.ssl? or local_request?)
      redirect_to :protocol=>'https://'
      flash.keep
    end
  end

  def is_integer?(to_test)
    begin
      Integer(to_test)
      true
    rescue ArgumentError
      false
    end
  end

  def is_bool?(to_test)
    to_test && (to_test.casecmp("false") == 0 || to_test.casecmp("true") == 0)
  end

  def to_bool(to_test)
    return false if to_test.casecmp("false") == 0
    return true if to_test.casecmp("true") == 0
    raise "#{to_test} - is not boolean"
  end

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password
end
