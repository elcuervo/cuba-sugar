require File.expand_path "../test_helper", __FILE__
require "cuba/sugar/as"

test "set status and headers through helper" do
  Cuba.plugin Cuba::Sugar::As
  Cuba.define do
    on "users" do
      as 201, {"Content-Location" => "http://somewhere.com/users/705"} do
        "User Created"
      end
    end
  end

  env = { "SCRIPT_NAME" => "/", "PATH_INFO" => "/users" }

  code, headers, resp = Cuba.call(env)

  assert_equal 201, code
  assert_equal ["User Created"], resp
  assert_equal "http://somewhere.com/users/705", headers["Content-Location"]
end

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
