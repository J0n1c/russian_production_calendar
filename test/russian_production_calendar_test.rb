require 'test_helper'

class RussianProductionCalendarTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil RussianProductionCalendar::VERSION
  end

  def test_new_year_is_a_holiday
    assert RussianProductionCalendar.is_holiday?(Date.parse('01.01.2018'))
    refute RussianProductionCalendar.is_workday?(Date.parse('01.01.2018'))
  end

  def test_first_working_day_is_not_holiday
    assert RussianProductionCalendar.is_workday?(Date.parse('10.01.2018'))
    refute RussianProductionCalendar.is_holiday?(Date.parse('10.01.2018'))
  end

  def test_shortened_day_is_not_holiday
    assert RussianProductionCalendar.is_workday?(Date.parse('22.02.2018'))
    refute RussianProductionCalendar.is_holiday?(Date.parse('22.02.2018'))
  end

  def test_unknown_day
    assert_nil RussianProductionCalendar.is_workday?(Date.parse('01.01.3000'))
    assert_nil RussianProductionCalendar.is_holiday?(Date.parse('01.01.3000'))
  end

  # @refs http://www.consultant.ru/law/ref/calendar/proizvodstvennye/2019/
  def test_each_month_holidays
    holidays = [
      Date.parse('01.01.2019'),
      Date.parse('02.02.2019'),
      Date.parse('08.03.2019'),
      Date.parse('13.04.2019'),
      Date.parse('04.05.2019'),
      Date.parse('12.06.2019'),
      Date.parse('20.07.2019'),
      Date.parse('03.08.2019'),
      Date.parse('14.09.2019'),
      Date.parse('05.10.2019'),
      Date.parse('09.11.2019'),
      Date.parse('01.12.2019')
    ]

    holidays.each do |day|
      assert RussianProductionCalendar.is_holiday?(day)
      refute RussianProductionCalendar.is_workday?(day)
    end
  end

  # @refs http://www.consultant.ru/law/ref/calendar/proizvodstvennye/2019/
  def test_each_month_workdays
    holidays = [
        Date.parse('14.01.2019'),
        Date.parse('01.02.2019'),
        Date.parse('07.03.2019'),
        Date.parse('08.04.2019'),
        Date.parse('01.05.2019'),
        Date.parse('11.06.2019'),
        Date.parse('05.07.2019'),
        Date.parse('09.08.2019'),
        Date.parse('20.09.2019'),
        Date.parse('04.10.2019'),
        Date.parse('05.11.2019'),
        Date.parse('31.12.2019')
    ]

    holidays.each do |day|
      assert RussianProductionCalendar.is_workday?(day)
      refute RussianProductionCalendar.is_holiday?(day)
    end
  end

  # @refs http://www.consultant.ru/law/ref/calendar/proizvodstvennye/2017/
  def test_lte_business_day_between_years
    assert_equal RussianProductionCalendar.lte_business_day(Date.parse('05.01.2018')), Date.parse('29.12.2017')
  end

  def test_lte_business_current
    assert_equal RussianProductionCalendar.lte_business_day(Date.parse('01.02.2018')), Date.parse('01.02.2018')
  end

  def test_lte_business_day_unknown
    assert_nil RussianProductionCalendar.lte_business_day(Date.parse('01.01.3000'))
  end

  def test_gte_business_day_between_years
    assert_equal RussianProductionCalendar.gte_business_day(Date.parse('05.01.2018')), Date.parse('09.01.2018')
  end

  def test_gte_business_current
    assert_equal RussianProductionCalendar.gte_business_day(Date.parse('09.01.2018')), Date.parse('09.01.2018')
  end

  def test_gte_business_day_unknown
    assert_nil RussianProductionCalendar.gte_business_day(Date.parse('01.01.3000'))
  end
end
