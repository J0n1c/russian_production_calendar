require 'russian_production_calendar/version'
require 'date'
require 'csv'

module RussianProductionCalendar
  CALENDAR_PATH = 'russian_production_calendar/holidays.csv'.freeze
  SHORTENED_POSTFIX = '*'.freeze
  DAY_SEP = ','.freeze

  MONTHS_MAP = {
    1 => 'Январь',
    2 => 'Февраль',
    3 => 'Март',
    4 => 'Апрель',
    5 => 'Май',
    6 => 'Июнь',
    7 => 'Июль',
    8 => 'Август',
    9 => 'Сентябрь',
    10 => 'Октябрь',
    11 => 'Ноябрь',
    12 => 'Декабрь'
  }.freeze

  extend self

  # @return [Boolean] true/false - выходной/рабочий
  # @return [nil] если текущего года/месяца нет в индексе
  def is_holiday?(date)
    days = index.dig(date.year, date.month) || return
    days.include?(date.day)
  end

  # @return [Boolean, nil]
  def is_workday?(date)
    result = is_holiday?(date)
    result.is_a?(NilClass) ? nil : !result
  end

  # @param [Date]
  # @return [Date] предыдущий рабочий день (или текущий, если он рабочий)
  def lte_business_day(day)
    loop do
      case is_workday?(day)
      when true
        break day
      when nil
        break
      else
        day = day.prev_day
      end
    end
  end

  # @param [Date]
  # @return [Date] следующий рабочий день (или текущий, если он рабочий)
  def gte_business_day(day)
    loop do
      case is_workday?(day)
      when true
        break day
      when nil
        break
      else
        day = day.next_day
      end
    end
  end

  def csv_calendar
    @csv_calendar ||= CSV.open(File.join(__dir__, CALENDAR_PATH), headers: true).map(&:to_h)
  end

  # @return [Hash([Integer] => Hash([Integer] => [Set]))]
  # @example {"2018" => { 1 => [1, 2, 3] }}
  def index
    @index ||= csv_calendar.each_with_object({}) do |row, object|
      year = Integer(row.fetch('Год/Месяц'))

      object[year] = MONTHS_MAP.each_with_object({}) do |(ix, name), obj|
        obj[ix] = row.fetch(name).split(DAY_SEP).each_with_object(Set.new) do |day, result|
          next if day[SHORTENED_POSTFIX]  # exclude shortened days
          result.add(Integer(day))
        end
      end
    end
  end
end
