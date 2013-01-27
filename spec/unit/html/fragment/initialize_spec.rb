require 'spec_helper'

# NOTE: This will move to class_methods/new_spec.rb with mutant-0.3.0!
describe HTML::Fragment, '#initialize' do
  let(:object) { described_class }

  subject { object.new(input) }

  let(:input) { Object.new }

  its(:content) { should eql(input) }

  it 'should freeze input' do
    subject
    input.frozen?.should be(true)
  end
end
