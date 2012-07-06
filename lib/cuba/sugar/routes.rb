module Cuba::Sugar
  module Routes
    # Public: Sugar to access an option verb
    #
    # Examples:
    #
    #   on options do
    #     as_json do
    #       API.interaction_methods
    #     end
    #   end
    def options
      req.options?
    end

    # Public: Sugar to do match a given subdomain. eg. blog.example.com
    #
    # subdomain - subdomain to be checked
    #
    # Examples:
    #
    #   on subdomain("blog") do
    #     as do
    #       run Blog
    #     end
    #   end
    def subdomain(sub)
      sub == req.host.split(".").first
    end
  end
end
