# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Unwrap, '#header' do
  subject { object.header }

  let(:object)   { described_class.new(relation, :names)         }
  let(:relation) { Relation.new(header, []).wrap(names: [:name]) }
  let(:header)   { [[:id, Integer], [:name, String]]             }

  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(Relation::Header) }

  it 'returns the expected attributes' do
    should == header
  end
end
