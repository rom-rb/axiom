require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#hash' do
  let(:relation) { Relation.new([ [ :id, Integer ] ], []) }

  subject { relation.hash }

  it { should be_kind_of(Integer) }

  it { should == relation.header.hash ^ relation.to_set.hash }
end
