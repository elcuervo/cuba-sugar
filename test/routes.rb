require File.expand_path "../test_helper", __FILE__
require "cuba/sugar/as"
require "cuba/sugar/routes"

test "eval only in a given subdomain" do
  Cuba.plugin Cuba::Sugar::As
  Cuba.plugin Cuba::Sugar::Routes
  Cuba.define do
    on subdomain("api"), root do
      as do
        "Subdomain"
      end
    end

    on root do
      as do
        "Main"
      end
    end
  end

  subdomain_env = { "SCRIPT_NAME" => "/", "PATH_INFO" => "/", "HTTP_HOST" => "api.example.com" }
  standard_env = { "SCRIPT_NAME" => "/", "PATH_INFO" => "/", "HTTP_HOST" => "example.com" }

  _, _, sub_resp = Cuba.call(subdomain_env)
  _, _, resp = Cuba.call(standard_env)

  assert_equal ["Subdomain"], sub_resp
  assert_equal ["Main"], resp
end
