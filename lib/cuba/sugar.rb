require 'json'
require "rack/csrf"

class Cuba

  def root; "".freeze; end

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

  def session
    env["rack.session"]
  end

  def redirect(*args)
    res.redirect(*args)
    @matched = true
  end

  # From sinatra/base
  def helpers(*extensions, &block)
    instance_eval(&block) if block_given?
    extend(*extensions)   if extensions.any?
  end

  def csrf_tag
    Rack::Csrf.tag(env)
  end

  def csrf_token
    Rack::Csrf.token(env)
  end

end
