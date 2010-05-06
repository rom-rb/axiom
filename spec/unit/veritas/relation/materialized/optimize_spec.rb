require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Materialized#optimize' do
  subject { relation.optimize }

  describe 'with an empty Array' do
    let(:relation) { Relation::Materialized.new([ [ :id, Integer ] ], []) }

    it { should eql(Relation::Empty.new(relation.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == relation
    end
  end

  describe 'with an nonempty Array' do
    let(:relation) { Relation::Materialized.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

    it { should equal(relation) }
  end
end
