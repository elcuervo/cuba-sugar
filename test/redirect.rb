require File.expand_path("helper", File.dirname(__FILE__))

test "redirect helper" do
  Cuba.define do
    on "old" do
      redirect "/new"
    end
  end

  env = { "SCRIPT_NAME" => "/", "PATH_INFO" => "/old" }

  _, _, resp = Cuba.call(env)

  assert_equal 302, resp.status
  assert_equal "/new", resp.headers["Location"]
end
