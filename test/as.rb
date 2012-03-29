require File.expand_path("helper", File.dirname(__FILE__))

test "set status and headers through helper" do
  Cuba.plugin Cuba::Sugar
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
