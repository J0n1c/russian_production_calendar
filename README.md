# RussianProductionCalendar

This gem checks holiday status of the given date.
Holidays data is hardcoded into csv file. The format of the holidays file is corresponds to the official one from http://data.gov.ru

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'russian_production_calendar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install russian_production_calendar

## Usage

```ruby
RussianProductionCalendar.is_holiday?(Date.parse('01.01.2018'))
RussianProductionCalendar.is_workday?(Date.parse('01.01.2018'))
RussianProductionCalendar.lte_business_day(Date.parse('01.01.2018'))
RussianProductionCalendar.gte_business_day(Date.parse('01.01.2018'))
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/J0n1c/russian_production_calendar.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
