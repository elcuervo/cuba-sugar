require File.expand_path("helper", File.dirname(__FILE__))

test "redirect helper" do
  Cuba.plugin Cuba::Sugar
  Cuba.define do
    on "old" do
      redirect "/new"
    end
  end

  env = { "SCRIPT_NAME" => "/", "PATH_INFO" => "/old" }

  code, headers, _ = Cuba.call(env)

  assert_equal 302, code
  assert_equal "/new", headers["Location"]
end
