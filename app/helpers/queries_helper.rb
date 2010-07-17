module QueriesHelper
  def query_status_icon(query, id_queried = false)
    icon_image_id = id_queried ? dom_id(query, :status_icon) : dom_id(query.form_field_value, :query_status_icon)
    tooltip_id = dom_id(query, :icon_tooltip)

    image_tag("icons/query-#{query.status}.png", :alt => query.status.capitalize, :id => icon_image_id) +
      common_loadable_tooltip(icon_image_id, "query-tooltip", query_path(query.id))
  end

  def query_new_icon(form_field_value)
    image_tag("icons/query-new.png", :alt => "Add query", :title => "Add query", :id => dom_id(form_field_value, :status_icon_new))
  end
end
