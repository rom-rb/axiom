require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation' do
  subject { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  it { should be_kind_of(Enumerable) }

  it 'case matches Enumerable' do
    (Enumerable === subject).should be(true)
  end
end

describe 'Veritas::Relation#each' do
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuples)   { [ [ 1 ], [ 2 ], [ 2 ] ]                    }
  let(:relation) { Relation.new(header, tuples)               }
  let(:yields)   { []                                         }

  subject { relation.each { |tuple| yields << tuple } }

  it { should equal(relation) }

  it 'yields each tuple only once' do
    method(:subject).should change { yields.dup }.from([]).to([ [ 1 ], [ 2 ] ])
  end
end
