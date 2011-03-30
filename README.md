Cuba/Sugar
==========

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

### as_json

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

Contributors
------------

  * [bemurphy](https://github.com/bemurphy) (Brendon Murphy)

Installation
------------

    $ gem install cuba-sugar
