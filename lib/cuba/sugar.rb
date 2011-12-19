require "cuba/contrib"
require "rack/csrf"

module Cuba::Sugar

  # Sugar to access root of a page
  #
  # @example
  # on post, root do
  #   as do
  #     "Welcome!"
  #   end
  # end
  def root; "" end

  # Sugar to access an option verb
  #
  # @example
  # on options do
  #   as_json do
  #     API.interaction_methods
  #   end
  # end
  def options; req.options? end

  # Sugar to easily access params
  #
  # @example
  # on get, root do
  #   as do
  #     "This id: #{params['id']}"
  #   end
  # end
  def params; req.params end

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

  # Sugar to do some common response tasks as_json
  #
  # @example
  # on post, "users" do
  #   as_json 201 do
  #     "User successfully created!"
  #   end
  # end
  def as_json(http_code = 200, extra_headers = {})
    require 'json'
    extra_headers["Content-Type"] ||= "application/json"
    as(http_code, extra_headers) do
      (yield).to_json if block_given?
    end
  end

  # Sugar to do match a given subdomain.
  # eg. blog.example.com
  #
  # @example
  # on subdomain("blog") do
  #   as do
  #     run Blog
  #   end
  # end
  def subdomain(sub)
    sub == req.host.split(".").first
  end

  # Sugar to access session info
  #
  # @example
  # on root do
  #   as do
  #     "User name: #{session['name']}"
  #   end
  # end
  def session
    env["rack.session"]
  end

  # Sugar to redirect a request
  #
  # @example
  # on "old" do
  #   redirect "/new"
  # end
  def redirect(*args)
    res.redirect(*args)
  end

  # Sugar to include helpers and access them from
  # views
  #
  # @example
  # helpers do
  #   def now
  #     Time.now
  #   end
  # end
  def helpers(*extensions, &block)
    instance_eval(&block) if block_given?
    extend(*extensions)   if extensions.any?
  end

  # Sugar to include a csrf tag
  #
  # @example
  # <form action="/new">
  #   <%= csrf_tag %>
  #   <input type="text" />
  # </form>
  def csrf_tag
    Rack::Csrf.tag(env)
  end

  # Sugar to access the csrf token
  #
  # @example
  # <%= csrf_token %>
  def csrf_token
    Rack::Csrf.token(env)
  end

end
