module Veritas
  module Algebra
    class Rename < Relation
      include Relation::Operation::Unary

      attr_reader :aliases

      def initialize(relation, aliases)
        @aliases = aliases
        super(relation)
      end

      def header
        @header ||= relation.header.rename(aliases)
      end

      def each(&block)
        relation.each do |tuple|
          yield Tuple.new(header, tuple.to_ary)
        end
        self
      end

      def directions
        @directions ||= relation.directions.rename(aliases)
      end

      def optimize
        relation = optimize_relation

        case relation
          when Relation::Empty              then new_empty_relation
          when self.class                   then optimize_rename(relation)
          when Projection                   then optimize_projection(relation)
          when Relation::Operation::Set     then optimize_set(relation)
          when Relation::Operation::Reverse then optimize_reverse(relation)
          when Relation::Operation::Order   then optimize_order(relation)
          else
            super
        end
      end

    private

      def new(relation)
        self.class.new(relation, aliases)
      end

      def new_optimized_operation
        self.class.new(optimize_relation, aliases)
      end

      def optimize_rename(other)
        aliases  = optimize_aliases(other)
        relation = other.relation

        if aliases.empty?
          # drop no-op renames
          relation
        else
          # combine renames together
          other.class.new(relation, aliases)
        end
      end

      def optimize_projection(projection)
        # push renames before the projection
        projection.class.new(new(projection.relation), header)
      end

      def optimize_set(set)
        # push renames before the set operation
        set.class.new(new(set.left), new(set.right))
      end

      def optimize_reverse(reverse)
        # push renames before the reverse
        reverse.class.new(new(reverse.relation))
      end

      def optimize_order(order)
        # push renames before the order
        order.class.new(new(order.relation), directions)
      end

      # TODO: create Rename::Aliases object, and move this to a #union method
      def optimize_aliases(other)
        aliases  = other.aliases.dup
        inverted = aliases.invert

        self.aliases.each do |old_attribute, new_attribute|
          old_attribute = inverted.fetch(old_attribute, old_attribute)

          if old_attribute == new_attribute
            aliases.delete(new_attribute)
          else
            aliases[old_attribute] = new_attribute
          end
        end

        aliases
      end

    end # class Rename
  end # module Algebra
end # module Veritas
