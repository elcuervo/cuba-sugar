require File.expand_path("helper", File.dirname(__FILE__))
require 'json'

test "set a block to return json" do
  rum_and_coke = { "rum" => "hot", "coke" => "sweet" }

  Cuba.plugin Cuba::Sugar
  Cuba.define do
    on "drinks" do
      as_json 201, {"Content-Location" => "http://somewhere.com/drinks/42"} do
        rum_and_coke
      end
    end
  end

  env = { "SCRIPT_NAME" => "/", "PATH_INFO" => "/drinks" }

  _, _, resp = Cuba.call(env)

  assert_equal 201, resp.status
  assert_equal "application/json", resp.headers["Content-Type"]
  assert_equal [rum_and_coke.to_json], resp.body
  assert_equal "http://somewhere.com/drinks/42", resp.headers["Content-Location"]
end
