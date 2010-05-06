require File.expand_path('../../../../spec_helper', __FILE__)

# use an infinite list to simulate handling a large Array.
# if any operation is inefficient, then the specs will never exit
class InfiniteList
  include Enumerable

  Infinity = 1.0/0.0

  def each
    (0..Infinity).each do |index|
      yield [ index ]
    end
    self
  end
end

describe 'Veritas::Algebra::Relation' do
  describe 'Efficient Enumerable operation' do
    let(:relation) { Relation.new([ [ :id, Integer ] ], InfiniteList.new) }

    def sample(relation)
      relation.enum_for.take(5)
    end

    it '#project should be efficient' do
      projected = relation.project([ :id ])
      sample(projected).should == [ [ 0 ], [ 1 ], [ 2 ], [ 3 ], [ 4 ] ]
    end

    it '#restrict should be efficient' do
      restricted = relation.restrict{ |r| r[:id].gt(5) }
      sample(restricted).should == [ [ 6 ], [ 7 ], [ 8 ], [ 9 ], [ 10 ] ]
    end

    it '#product should be efficient' do
      product = relation.product(Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ] ]))
      sample(product).should == [ [ 0, 'Dan Kubb' ], [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ], [ 3, 'Dan Kubb' ], [ 4, 'Dan Kubb' ] ]
    end

    it '#difference should be efficient' do
      difference = relation.difference(Relation.new(relation.header, [ [ 1 ] ]))
      sample(difference).should == [ [ 0 ], [ 2 ], [ 3 ], [ 4 ], [ 5 ] ]
    end

    it '#union should be efficient' do
      union = relation.union(Relation.new(relation.header, [ [ 1 ] ]))
      sample(union).should == [ [ 0 ], [ 1 ], [ 2 ], [ 3 ], [ 4 ] ]
    end

    it '#rename should be efficient' do
      renamed = relation.rename(:id => :other_id)
      sample(renamed).should == [ [ 0 ], [ 1 ], [ 2 ], [ 3 ], [ 4 ] ]
    end
  end
end
