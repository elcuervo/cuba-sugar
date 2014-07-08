module Cuba::Sugar
  module As
    # Public: Sugar to do some common response tasks
    #
    # http_code     - Response status code (default: 200)
    # extra_headers - Extra headers hash (default: {})
    #
    # Examples:
    #
    #   on post, "users" do
    #     as 201 do
    #       "User successfully created!"
    #     end
    #   end
    def as(http_code = 200, extra_headers = {}, &block)
      res.status = http_code
      res.headers.merge! extra_headers
      yield if block
    end

    # Public: Sugar to do some common response tasks as_json
    #
    # http_code     - Response status code (default: 200)
    # extra_headers - Extra headers hash (default: {})
    # Examples:
    #
    #   on post, "users" do
    #     as_json 201 do
    #       "User successfully created!"
    #     end
    #   end
    def as_json(http_code = 200, extra_headers = {}, &block)
      require 'json'
      extra_headers["Content-Type"] ||= "application/json"
      as(http_code, extra_headers) { yield.to_json if block }
    end
  end
end
