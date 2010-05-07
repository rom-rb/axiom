require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Inclusion#optimize' do
  let(:left) { Attribute::Integer.new(:id) }

  subject { inclusion.optimize }

  context 'left is an attribute' do
    context 'right is a Range' do
      context 'that is inclusive' do
        context 'and empty' do
          let(:right)     { 1..0                                         }
          let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

          it { should equal(Logic::Proposition::False.instance) }
        end

        context 'and not empty' do
          let(:right)     { 1..10                                        }
          let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

          it { should equal(inclusion) }
        end
      end

      context 'that is exclusive' do
        context 'and empty' do
          let(:right)     { 1...1                                        }
          let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

          it { should equal(Logic::Proposition::False.instance) }
        end

        context 'and not empty' do
          let(:right)     { 1...10                                       }
          let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

          it 'changes the Range to be inclusive' do
            should eql(left.in(1..9))
          end
        end
      end

      context 'using an attribute that is not comparable' do
        let(:left)      { Attribute::String.new(:string)                  }
        let(:inclusion) { Logic::Predicate::Inclusion.new(left, 'a'..'z') }

        it { should equal(Logic::Proposition::False.instance) }
      end

      context 'that is greater than the left range' do
        let(:right)     { 2**31..2**31                                 }
        let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

        it { should equal(Logic::Proposition::False.instance) }
      end

      context 'that is less than the left range' do
        let(:right)     { -1..-1                                       }
        let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

        it { should equal(Logic::Proposition::False.instance) }
      end
    end

    context 'right is an Enumerable' do
      context 'that is empty' do
        let(:right)     { []                                           }
        let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

        it { should equal(Logic::Proposition::False.instance) }
      end

      context 'that is empty after filtering invalid values' do
        let(:right)     { [ 'a' ]                                      }
        let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

        it { should equal(Logic::Proposition::False.instance) }
      end

      context 'that is not empty after filtering invalid values' do
        let(:right)     { [ 'a', 1 ]                                   }
        let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

        it { should eql(left.in([ 1 ])) }
      end
    end

    context 'right is a nil' do
      let(:right)     { nil                                          }
      let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end