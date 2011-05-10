module Veritas
  class Aggregate

    # The maximum value in a sequence of numbers
    class Maximum < Aggregate

      DEFAULT = -Float::INFINITY

      # Return the maximum value for a sequence of numbers
      #
      # @example
      #   maximum = Maximum.call(maximum, value)
      #
      # @param [Numeric] maximum
      #
      # @param [Numeric] value
      #
      # @return [Numeric]
      #
      # @api public
      def self.call(maximum, value)
        value > maximum ? value : maximum
      end

      module Methods
        extend Aliasable

        inheritable_alias(:max => :maximum)

        # Return a maximum aggregate function
        #
        # @example
        #   maximum = attribute.maximum
        #
        # @param [Attribute]
        #
        # @return [Maximum]
        #
        # @api public
        def maximum
          Maximum.new(self)
        end

      end # module Methods
    end # class Maximum
  end # class Aggregate
end # module Veritas