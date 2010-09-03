require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::Equality::AlwaysTrue#optimizable?' do
  subject { object.optimizable? }

  let(:klass)     { Optimizer::Logic::Predicate::Equality::AlwaysTrue }
  let(:attribute) { Attribute::Integer.new(:id)                       }
  let(:predicate) { left.eq(right)                                    }
  let(:object)    { klass.new(predicate)                              }

  before do
    predicate.should be_kind_of(Veritas::Logic::Predicate::Equality)
  end

  context 'when left and right are equal' do
    let(:left)  { attribute }
    let(:right) { attribute }

    it { should be(true) }
  end

  context 'when left and right are not equal' do
    let(:left)  { attribute }
    let(:right) { 1         }

    it { should be(false) }
  end
end