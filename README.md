# Resque::Reports

Make your custom reports to CSV in background using Resque with simple DSL.

## Instalation

Add this line to your application's Gemfile:

```ruby
gem 'resque-reports'
```

And then execute:

    $ bundle

## Examples:

### Basic usage

``` ruby
class CsvUserRepost < Resque::Reports::CsvReport
  queue :csv_reports
  source :select_data

  directory Rails.root.join('public/reports')

  table do
    column 'ID', :id
    column 'Name', :name
  end

  def select_data
    User.all
  end
end
```

in you controller:

``` ruby
class ReporstController < ApplicationController
  def create
    job_id = report.bg_build

    render json: {job_id: job_id}
  end

  def show
    if report.exits?
      send_file(report.filename, filename: 'users.csv')
    else
      redirect :back
    end
  end

  private

  def report
    @report ||= CsvUserRepost.new
  end
end
```

### Advanced usage

``` ruby
class CsvUserRepost < Resque::Reports::CsvReport
  queue :csv_reports
  source :select_data
  encoding CP1251

  directory Rails.root.join('public/reports')

  create do |age, date|
    @age = age
    @date = date
  end

  table do
    column 'ID', :id
    column 'Name', :name
    column 'Created at', :created_at, formatter: :date
  end

  def select_data
    User.where('age = ? and create_at >= ?', [age, date])
  end

  def date_formatter(value)
    Date.parse(value).strftime('%d.%m.%Y')
  end
end
```

in you controller:

``` ruby
class ReporstController < ApplicationController
  #...

  private

  def report
    @report ||= CsvUserRepost.new(params[:age], params[:date])
  end
end
```

Copyright (c) 2013 Dolganov Sergey, released under the MIT license
