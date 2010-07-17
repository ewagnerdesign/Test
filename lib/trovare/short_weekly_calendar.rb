# -*- coding: utf-8 -*-
# ShortWeeklyCalendar by Dan McGrady 2009

module Trovare

  module ShortWeeklyCalendar

    def short_weekly_calendar(*args)
      #view helper to build the weekly calendar
      options = args.last.is_a?(Hash) ? args.pop : {}
      date = options[:date] || Date.today
      start_date = date.beginning_of_week
      end_date = date.end_of_week

      concat(tag("div", {:id => "week"}, true))

      yield ShortWeeklyCalendar::Builder.new(self, options, start_date, end_date)

      concat("</div>")
    end

    def short_weekly_links(options)
      #view helper to insert the next and previous week links
      date = options[:date] || Date.today
      start_date = date.beginning_of_week
      end_date = date.end_of_week
      options.delete :date
      concat(link_to_remote "<< Previous Week", { :method => :get, :url => dashboard_path(options.merge(:date => start_date - 1.week))})
      concat(" #{start_date.strftime('%d-%b-%Y').upcase} - #{end_date.strftime('%d-%b-%Y').upcase} ")
      concat(link_to_remote "Next Week >>", { :method => :get, :url => dashboard_path(options.merge(:date => start_date.next_week))})
    end
  end
end
ActionView::Base.send :include, Trovare::ShortWeeklyCalendar
