require "russian_production_calendar/version"
require 'date'
require 'russian'
require 'csv'

module RussianProductionCalendar

  CALENDAR_PATH = 'russian_production_calendar/holidays.csv'.freeze

  extend self

  def csv_calendar
    @csv_calendar ||= CSV.foreach(File.join(__dir__, CALENDAR_PATH), headers: true).map(&:to_h)
  end

  def is_holiday?(date)
    month = Russian.strftime(date, '%B')
    csv_calendar.find { |record| record['Год/Месяц'] == date.year.to_s }[month].gsub('*', '').split(',').include?(date.day.to_s)
  end
end
