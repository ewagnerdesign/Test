module Trovare
  class ShortWeeklyCalendar::Builder
    include ::ActionView::Helpers::TagHelper

    def initialize(template, options, start_date, end_date)
      @template, @options, @start_date, @end_date = template, options, start_date, end_date
    end

    def week
      concat(tag("div", { :id => "days" }, true))
      for day in @start_date..@end_date
        day_id = (day.today?)? "day_today" : "day"
        concat(tag("div", { :id => day_id }, true))
        concat(content_tag("b", day.strftime('%A')))
        concat(tag("br"))
        concat(day.strftime('%B %d'))
        concat(tag("div", { :id => "day_content" }, true))
        yield(day)
        concat("</div>")
        concat("</div>")
      end
      concat("</div>")
    end

    private

    def concat(tag)
      @template.concat(tag)
    end

  end
end
