require 'spec_helper'

describe HTML, '.attributes' do
  let(:object) { described_class }

  subject { object.attributes(input) }

  examples = {
    { 'foo'  => 'bar' } => ' foo="bar"',
    { 'foo'  => '"'   } => ' foo="&quot;"',
    { 'foo'  => '&'   } => ' foo="&amp;"',
    { :class => :baz  } => ' class="baz"'
  }

  examples.each do |input, expectation|
    context "with #{input} as input" do
      let(:input) { input }
      it { should eql(expectation) }
    end
  end
end
