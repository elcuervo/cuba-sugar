require File.expand_path("helper", File.dirname(__FILE__))
require 'cuba/sugar'

test "set status and headers through helpers" do
  Cuba.plugin Cuba::Sugar
  Cuba.define do
    helpers do
      def upperize(string)
        string.upcase
      end
    end

    on "users" do
      as do
        "I will shout: #{upperize("hello")}"
      end
    end
  end

  env = { "SCRIPT_NAME" => "/", "PATH_INFO" => "/users" }

  _, _, resp = Cuba.call(env)

  assert_equal ["I will shout: HELLO"], resp
end
