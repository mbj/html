require 'spec_helper'

describe HTML, '.escape' do
  let(:object) { described_class }

  subject { object.escape(string) }

  examples = {
    'foo' => 'foo',
    '<>'  => '&gt;&lt;',
    '<foo>'  => '&gt;foo&lt;',
    '<foo bar="baz">'  => '&gt;foo bar=&amp;baz&amp;&lt;'
  }

  examples.each do |input, expectation|
    context "with #{input} as input" do
      let(:string) { input }
      it { should eql(expectation) }
    end
  end
end
