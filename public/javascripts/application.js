// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//Tabs
var global_loader_map = [];

(function($) {
    $.fn.tabify = function() {
        var tabContainers = this.children('div');
        tabContainers.hide().filter(':first').show();

        var self = this;
        this.find('ul.tabNavigation a').click(function(){
            tabContainers.hide();
            tabContainers.filter(this.hash).show();
            self.find('ul.tabNavigation a').removeClass('selected');
            $(this).addClass('selected');
            if(!global_loader_map[this.hash].loaded) {
              global_loader_map[this.hash].loader();
            }
            return false;
        }).filter(':first').click();
    };
})(jQuery);

jQuery(document).ready(function(){
    jQuery('.tabs').tabify();
    jQuery.ajaxSetup({
        beforeSend: function() { $('#loader').show() },
        complete:   function() {
            $('#loader').hide();
            ajax_pagination(); // For ajax requests
        },
        //Reinit thickbox handlers
        success: function() { }
    });
    ajax_pagination(); // For non-ajax requests
});

// CRUD
function close_previous_crud_form() {
  var form = $('.crud-form')
  if(form.size() < 1) return true;
  var proceed = confirm("You have an open form on a screen.\nBy proceeding all the data from that form will be lost.\nContinue?")
  if(!proceed) return false;
  form.parent().children('.close').click()
  return true;
}

// based on http://wiki.github.com/mislav/will_paginate/ajax-pagination
function ajax_pagination() {
  $.each($('.pagination a:not(.ajax-pagination)'), function(index, value){
    var url = value.href;
    value.onclick = function(){
      $.getScript(url)
    }
    value.href = "javascript:void(0)";
    $(value).addClass('ajax-pagination')
  })
}


jQuery.fn.checkboxify = function() {
	return this.each(function() {
		jQuery(this).data('checked', jQuery(this).is(':checked'));

		jQuery(this).click(function(){
			var radio = jQuery(this);

			if (radio.data('checked')) {
				radio.attr('checked', false).data('checked', false);
			} else {
				jQuery('input[name="' + radio.attr('name') + '"]').attr('checked', false).data('checked', false);
				radio.attr('checked', true).data('checked', true);
			}
		});
	});
}

//Aply checkbox behaviour to all eCRF form radioboxes
$(document).ready(function() {
  $('.uniForm input:radio').checkboxify();

});


$(document).ready(function() {
  // hide flash messages
  setTimeout(function(){
    $('.flash_message').each(function(){
      $(this).fadeOut('slow')
    })
  }, 15000)
})



$.fn.extend({
   disableSelection: function(){
      this.each(function(){
        if( $.browser.msie ){
          this.onselectstart = function(){ return false; }
          this.unselectable = "on"
        }
//         $(this).css('-moz-user-select', 'none').css()
         $(this).css('-moz-user-select', '-moz-none').css('-khtml-user-select', 'none')
      })
   },

  enableSelection: function(){
    if( $.browser.msie ){
      this.onselectstart = function(){ return true; }
      this.unselectable = "off"
    }
    $(this).css('-moz-user-select', 'text').css('-khtml-user-select', 'text')
  }

})

$(document).ready(function() {
    $('.unselectable').disableSelection()

})