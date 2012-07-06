require 'cuba/sugar/as'
require 'cuba/sugar/csrf'
require 'cuba/sugar/routes'
require 'cuba/sugar/content_for'

module Cuba::Sugar
  include As
  include Csrf
  include Routes
  include ContentFor

  # Public: Sugar to include helpers
  #
  # *extensions - Modules to be evaluated
  # &block      - Methods to be included
  #
  # Examples:
  #
  #   helpers do
  #     def now
  #       Time.now
  #     end
  #   end
  def helpers(*extensions, &block)
    instance_eval(&block) if block
    extend(*extensions)   if extensions.any?
  end
end
