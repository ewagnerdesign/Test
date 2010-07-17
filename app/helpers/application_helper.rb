# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def icon(name, *args)
    image_tag(image_path('icons/'+name.to_s+'.png'), *args)
  end

  def highlightable(id = nil, use_hide_and_show = false)
    if use_hide_and_show
      show = (id ? "$('##{id}').show()" : "")
      hide = (id ? "$('##{id}').hide()" : "")
    else
      show = (id ? "$('##{id}').style.visibility='visible'" : "")
      hide = (id ? "$('##{id}').style.visibility='hidden'" : "")
    end

      " onmouseover = \"this.style.background='seashell'; #{show}\"" +
      " onmouseout =  \"this.style.background='white'; #{hide}\""
  end

  def highlight_search_result(value, current_query)
    begin
      current_query.blank? ? value : value.to_s.gsub(/(#{current_query})/i, "<span style='color:red;'>\\1</span>")
    rescue
      value #TODO: processing for '*', '?', '\\' etc
    end
  end

  def dom_id_nested_controller(controller_name, prefix, *parent_entity)
    path = parent_entity.collect {|x| x ? dom_id(x).to_s : '' }.join('-')
    "#{prefix}" + (path.blank? ? "" : "-#{path}") + (controller_name.blank? ? "" : "-" + controller_name)
  end

  def dom_id_nested(prefix, *parent_entity)
    dom_id_nested_controller(controller_name, prefix, *parent_entity)
  end

  def dom_id_n(prefix, *parent_entity)
    dom_id_nested_controller("", prefix, *parent_entity)
  end

  def gender_select(object, method)
    select(object, method, [["Male", "M"], ["Female", "F"]], { :prompt => true }, { })
  end

  def lazy_ajax_loader(id, url)
    render :partial => "common/lazy_ajax_loader", :locals => { :id => id, :url => url }
  end

  def filter_bar()
    study_id = @current_query[:study_id]
    study = study_id.zero? ? nil : Study.find(study_id, :include => [:study_arms, :subjects, :visits])

    render :partial => "common/crud/filter_bar", :locals => {:study => study}
  end

  def filter_form(url, parent_entity = nil)
    render :partial => "common/crud/filter_form", :locals => {
        :url => url,
        :parent_entity => parent_entity
      }
  end

  def clickable(url)
    " onclick = \""+remote_function(:method => :get, :url => url) + "; return false;\""
  end

  def link_to_box(*args)
    args.second.merge!({:TB_iframe => true})
    link_to args
  end

  def loader_image
    image_tag "loading.gif", :style => "display:none", :id => "loader"
  end

  def link_to_close(url)
      content_tag("div", "x",
        :class => "close", :title => t(:close_form),
        :onmouseover => "this.style.background='lightsalmon'",
        :onmouseout => "this.style.background='lightblue'",
        :onclick => remote_function(:url => url, :method => :get, :with => "'cancel=true'")
      )
    end

  def highlight(element)
    return "" unless element

  end

  def link_to_cancel(title, url)
    link_to_remote title, {:method => :get, :url => url, :with => "'cancel=true'"}
  end

  def link_to_ni(title)
     link_to_function title, "alert('Not implemented')"
   end

   def bool_to_s(value)
     (value ? "Yes":"No")
   end

   #FIXME I feel that there is some standard solution fot conditional remote link
   #do not know it for now :(
   def link_to_remote_if condition, name, options ={}, html_options = {}
     condition ? link_to_remote(name, options, html_options) : name
   end

  def date_picker(options)
    default_options = { :dateFormat  => 'dd-M-yy',
                        :changeMonth => true,
                        :changeYear  => true,
                        :yearRange   => '-125:+0',
                        :control_id  => nil,
                        :show_time   => nil,
                        :maxDate     => nil
    }

    render :partial => "common/crud/date_picker", :locals => default_options.merge(options)
  end

  def obj_query_status_icon(obj)
    return "&nbsp;" if obj.nil?

    queries = Query.find_by_obj(obj)
    return "&nbsp;" if queries.count == 0

    unreplied_query_count = queries.inject(0){|cnt, q| cnt + (!q.closed && q.need_reply? ? 1 : 0)}

    if unreplied_query_count == 0
      icon_name = "replied"
      alt = "All #{queries.count} queries replied"
    else
      icon_name = "unreplied"
      alt = "#{unreplied_query_count} queries unreplied, #{queries.count} total"
    end

    image_tag("icons/query-#{icon_name}.png", :alt => alt, :title => alt)
  end

  def obj_submit_status_icon(obj)
    if obj.nil? || obj.is_a?(FormInstance)
      if obj.nil?
        icon_name = "empty"
      else
        icon_name = (obj.submitted?) ? "submitted" : "saved"
      end
    else
      form_instances = obj.form_instances
      if form_instances.empty?
        icon_name = "empty"
      else
        icon_name = (form_instances.all?{|fi| fi.submitted})? "submitted" : "saved"
      end
    end

    alt = icon_name.capitalize
    image_tag "icons/ecrf-status-#{icon_name}.png", :alt => alt, :title => alt
  end

  def obj_monitored_status_icon(obj)
    return "&nbsp;" if obj.nil?

    ffvs = FormFieldValue.find_by_obj(obj)
    return "&nbsp;" if ffvs.count == 0

    monitored_ffv_count = ffvs.inject(0){|cnt, ffv| cnt + (ffv.monitored ? 1 : 0)}

    if monitored_ffv_count == ffvs.count
      icon_name = "monitored"
      alt = "All #{ffvs.count} values monitored"
    else
      icon_name = "not-monitored"
      alt = "#{ffvs.count - monitored_ffv_count} values not monitored, #{ffvs.count} total"
    end

    image_tag("icons/ffv-#{icon_name}.png", :alt => alt, :title => alt)
  end

  # host_id - id of the element to provide a tooltip for, url - load tooltip content from
  # should be put exactly after the host element
  def loadable_tooltip(host_id, url)
    render :partial => "common/loadable_tooltip", :locals => { :host_id => host_id, :url => url }
  end

  # host_id - id of the element to provide a tooltip for, url - load tooltip content from
  # will load content of the tooltip to #tooltip_id element
  def common_loadable_tooltip(host_id, tooltip_id, url)
    raw render :partial => "common/common_loadable_tooltip", :locals => { :host_id => host_id, :tooltip_id => tooltip_id, :url => url }
  end

  def double_truncate(words, word_length, sentence_length)
    truncate(words.map { |w| truncate(w, :length => word_length)}.join(", "), :length => sentence_length)
  end
end
