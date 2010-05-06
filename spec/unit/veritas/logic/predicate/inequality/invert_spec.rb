require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Inequality#invert' do
  let(:attribute)  { Attribute::Integer.new(:id) }
  let(:inequality) { attribute.ne(1)             }

  subject { inequality.invert }

  it { should eql(attribute.eq(1)) }

  it 'inverts back to original' do
    subject.invert.should eql(inequality)
  end
end
