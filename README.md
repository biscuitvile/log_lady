# LogLady

"My log sees everything."

Log Lady tracks changes in your ActiveRecord models so you can more easily implement audit logs or activity feeds in your Rails app. Specifically, your models will have a `logs` association and logs will produce descriptions in one or more customizable formats.

## Installation

Add this line to your application's Gemfile:

    gem 'log_lady'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install log_lady

## Usage

LogLady will automatically be available to your ActiveRecord models. To start logging on all attributes you can define the following in your model:

```ruby
class Car < ActiveRecord::Base
  log_lady_sees :everything
end
```

Now create, update, and destroy actions will generate logs. For example when updating:

```ruby
car = Car.first
car.update_attribute!(:mileage, '14,101')
```

A new log is written and accessible in the `car` object's `logs` association:

```ruby
car.logs.last.description
```

By default this will produce the following output:

```html
<span class="log-attr">mileage</span> was changed from <span class="log-val log-from">12,120</span> to <span class="log-val log-to">14,101</span>
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
