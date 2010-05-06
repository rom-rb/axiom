require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute.coerce' do
  subject { Attribute.coerce(object) }

  describe 'when the object is an Attribute' do
    let(:object) { Attribute::Integer.new(:id) }

    it { should equal(object) }
  end

  describe 'when the object responds to #to_ary' do
    let(:object) { [ :id, Integer ] }

    it { should eql(Attribute::Integer.new(:id)) }
  end
end
