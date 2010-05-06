require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Union#optimize' do
  let(:header)         { [ [ :id, Integer ] ]            }
  let(:original_left)  { Relation.new(header, [ [ 1 ] ]) }
  let(:original_right) { Relation.new(header, [ [ 2 ] ]) }
  let(:union)          { Algebra::Union.new(left, right) }

  subject { union.optimize }

  describe 'left is an empty relation' do
    let(:left)  { Relation::Empty.new(header) }
    let(:right) { original_right              }

    it { should equal(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end
  end

  describe 'right is an empty relation' do
    let(:left)  { original_left               }
    let(:right) { Relation::Empty.new(header) }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end
  end

  describe 'left is an empty relation when optimized' do
    let(:left)  { Algebra::Restriction.new(original_left, Logic::Proposition::False.instance) }
    let(:right) { original_right                                                              }

    it { should equal(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end
  end

  describe 'right is an empty relation when optimized' do
    let(:left)  { original_left                                                                }
    let(:right) { Algebra::Restriction.new(original_right, Logic::Proposition::False.instance) }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end
  end

  describe 'left and right are not empty relations' do
    let(:left)  { original_left  }
    let(:right) { original_right }

    it { should equal(union) }
  end

  describe 'left and right are equivalent relations' do
    let(:left)  { original_left }
    let(:right) { left.dup      }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end
  end
end
