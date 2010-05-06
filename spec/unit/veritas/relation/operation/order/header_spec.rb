require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#header' do
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:directions) { [ relation[:id] ]                                    }
  let(:order)      { Relation::Operation::Order.new(relation, directions) }

  subject { order.header }

  it { should be_kind_of(Relation::Header) }

  it { should equal(relation.header) }
end
