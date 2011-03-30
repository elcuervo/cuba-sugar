module Cuba
  class Ron
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
  end
end
