Cuba/Sugar
==========

![Build Status](https://secure.travis-ci.org/elcuervo/cuba-sugar.png)

_n_. bundled sugar for [cuba](https://github.com/soveran/cuba)

!["See this fucking sugar road? I just fucking made it"](http://maynardswitzer.com/library/Cuba/2002CubaSugarCaneCutterInField.A.jpg)

Description
-----------

It's like contrib stuff but with a cooler name.
Provides helpers and utilities to use with cuba.

Usage
-----

Like any other cuba app, but provides:

### as

```ruby
require "cuba"
require "cuba/sugar"

Cuba.use Rack::Session::Cookie

Cuba.define do
  on post do
    on "users" do
      # create user
      as 201, {"Content-Location" => "http://somewhere.com/users/705"} do
        "user #{user.id} created"
      end
    end
  end
end
```

### as_json

```ruby
require "cuba"
require "cuba/sugar"

Cuba.use Rack::Session::Cookie

Cuba.define do
  on get do
    on "weather" do
      as_json do
        {
          city:         'La Habana',
          temperature:  '19 °C',
          pressure:     '1014 hPa',
        }
      end
    end
  end
end
```

### csrf_tag && csrf_token

In the forms:

```ruby
<%= csrf_tag %>
```

In the code:

```ruby
require "cuba"
require "cuba/sugar"

Cuba.use Rack::Csrf

Cuba.define do
  # Automatic csrf validation
  on post
  end
end
```

### helpers

```ruby
require "cuba"
require "cuba/sugar"

Cuba.define do
  helpers do
    def now
      Time.now
    end
  end

  on "time" do
    as { "The current time is: #{now}" }
  end
end
```

Contributors
------------

  * [bemurphy](https://github.com/bemurphy) (Brendon Murphy)

Installation
------------

    $ gem install cuba-sugar
