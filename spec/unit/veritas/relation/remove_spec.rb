require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#remove' do
  let(:relation) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ]) }

  subject { relation.remove([ :id ]) }

  it { should be_kind_of(Algebra::Projection) }

  its(:header) { should == [ [ :name, String ] ] }

  it 'behaves the same as Enumerable#map with Tuple#[]' do
    should == relation.map { |tuple| [ tuple[:name] ] }
  end
end
