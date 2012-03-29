require File.expand_path("helper", File.dirname(__FILE__))
require 'cuba/render'

test "set status and headers through helper" do
  Cuba.plugin Cuba::Sugar
  Cuba.plugin Cuba::Render
  Cuba.define do
    on "users" do
      as do
        render "test/fixtures/csrf.erb"
      end
    end
  end

  env = { "SCRIPT_NAME" => "/", "PATH_INFO" => "/users", 'rack.session' => {} }

  code, headers, resp = Cuba.call(env)

  assert env.fetch("rack.session").has_key?("csrf.token")
  assert /_csrf/ =~ resp.first
  assert_equal 44, env.fetch("rack.session").fetch("csrf.token").size
end
