require File.expand_path("helper", File.dirname(__FILE__))
require 'cuba/sugar/as'

test "set a block to return json" do
  rum_and_coke = { "rum" => "hot", "coke" => "sweet" }

  Cuba.plugin Cuba::Sugar::As
  Cuba.define do
    on "drinks" do
      as_json 201, {"Content-Location" => "http://somewhere.com/drinks/42"} do
        rum_and_coke
      end
    end
  end

  env = { "SCRIPT_NAME" => "/", "PATH_INFO" => "/drinks" }

  code, headers, resp = Cuba.call(env)

  assert_equal 201, code
  assert_equal "application/json", headers["Content-Type"]
  assert_equal [rum_and_coke.to_json], resp
  assert_equal "http://somewhere.com/drinks/42", headers["Content-Location"]
end
