require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#hash' do
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }

  subject { header.hash }

  it { should be_kind_of(Integer) }

  it { should == header.to_ary.hash }
end
