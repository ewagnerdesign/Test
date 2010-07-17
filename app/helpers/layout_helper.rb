module LayoutHelper

  def title(title, show_title=true)
    @content_for_title = title
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def show_flash
     page.replace_html "flash_messages", render(:partial=>"layouts/flash_messages")
     page.delay(15) do
        page.call "
          $('.flash_message').each(function(){
             $(this).fadeOut('slow')
           })
        "
     end
  end

end