module Cuba::Sugar
  module ContentFor
    # Public: yields a content in a view
    #
    # symbol - The symbol to be searched
    #
    # Examples:
    #
    #   <% yield_for :menu %>
    def yield_for(symbol)
      content_blocks[symbol].map(&:call)
    end

    # Public: Sets a content for a given symbol
    #
    # symbol - The symbol key
    # &block - Block to be called
    #
    # Examples:
    #
    #   <% content_for :menu do %>
    #     Home | Admin
    #   <% end %>
    def content_for(symbol, &block)
      content_blocks[symbol] << block
    end

    private

    # Private: Hash of arrays to store content blocks
    def content_blocks
      @content_blocks ||= Hash.new { |h, k| h[k] = [] }
    end
  end
end
