shared_examples_for 'an optimize method' do
  it_should_behave_like 'an idempotent method'

  it 'does not optimize further' do
    object = subject
    object.optimize.should equal(object)
  end
end