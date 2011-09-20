require 'json'
require "rack/csrf"

class Cuba
  # Sugar to do some common response tasks
  #
  # @example
  # on post, "users" do
  #   as 201 do
  #     "User successfully created!"
  #   end
  # end
  def as(http_code = 200, extra_headers = {})
    res.status = http_code
    res.headers.merge! extra_headers
    res.write yield if block_given?
  end

  def as_json(http_code = 200, extra_headers = {})
    extra_headers["Content-Type"] ||= "application/json"
    as(http_code, extra_headers) do
      (yield).to_json if block_given?
    end
  end

  # This could be done in a better way within
  # a Tilt helper...
  def csrf_tag
    Rack::Csrf.tag(env)
  end

  def csrf_token
    Rack::Csrf.token(env)
  end

end
