require "test_helper"

class RussianProductionCalendarTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RussianProductionCalendar::VERSION
  end

  def test_new_year_is_a_holiday
    assert RussianProductionCalendar.is_holiday?(Date.parse('01.01.2018'))
  end

  def test_first_working_day_is_not_holiday
    assert !RussianProductionCalendar.is_holiday?(Date.parse('10.01.2018'))
  end

  def test_first_working_day_is_not_holiday
    assert !RussianProductionCalendar.is_holiday?(Date.parse('10.01.2018'))
  end

  def test_shortened_day_is_not_holiday
    assert !RussianProductionCalendar.is_holiday?(Date.parse('22.02.2018'))
  end

end
