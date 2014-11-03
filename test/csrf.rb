require_relative "test_helper"
require "cuba/render"
require "cuba/sugar/as"
require "cuba/sugar/csrf"

test "set status and headers through helper" do
  Cuba.plugin Cuba::Sugar::As
  Cuba.plugin Cuba::Sugar::Csrf
  Cuba.plugin Cuba::Render

  Cuba.settings[:render][:views] = "./test/fixtures"
  Cuba.settings[:render][:template_engine] = "erb"

  Cuba.define do
    on "users" do
      as do
        partial "csrf"
      end
    end
  end

  env = { "SCRIPT_NAME" => "/", "PATH_INFO" => "/users", "rack.session" => {} }

  code, headers, resp = Cuba.call(env)

  assert env.fetch("rack.session").has_key?("csrf.token")
  assert /_csrf/ =~ resp.first
  assert_equal 44, env.fetch("rack.session").fetch("csrf.token").size
end
