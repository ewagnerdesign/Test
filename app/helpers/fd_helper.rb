module FdHelper

  def validator_message_tag(name, message="Message")
    link_to_function( message, "$('##{sanitize_to_id(name)}').toggle()", :class=>"validator-message" ) +  
    text_area_tag( name, nil, :style=>"display: none", :class=>"validator-message" )
  end

end
