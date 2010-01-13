module Veritas
  module Algebra
    module CombineOperation
      include BinaryOperation

      def header
        @header ||= left.header | right.header
      end

      def body
        @body ||= self.class::Body.new(header, left.body, right.body)
      end

    private

      def self.combine_tuples(header, left_tuples, right_tuple)
        left_tuples.map { |left_tuple| yield(Tuple.new(header, left_tuple.to_ary + right_tuple.to_ary)) }
      end

    end # module CombineOperation
  end # module Algebra
end # module Veritas
