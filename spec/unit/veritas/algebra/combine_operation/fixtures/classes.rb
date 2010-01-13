module CombineOperationSpecs
  class Object
    include Veritas::Algebra::CombineOperation

    class Body < Relation::Body
      def initialize(header, left, right)
        @header, @left, @right = header, left, right
      end

      def each
        @left.each  { |tuple| yield tuple.project(@header) }
        @right.each { |tuple| yield tuple.project(@header) }
        self
      end
    end
  end
end
