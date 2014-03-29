# encoding: UTF-8

require 'spec_helper'

describe HTML, '.join' do
  let(:object) { described_class }

  subject { object.join(input) }

  examples = {
    []                                      => '',
    ['foo']                                 => 'foo',
    ['foo',   'bar']                        => 'foobar',
    ['foo',   HTML::Fragment.new('bar')]    => 'foobar',
    ['foo',   HTML::Fragment.new('<bar>')]  => 'foo<bar>',
    ['<foo>', HTML::Fragment.new('<bar>')]  => '&gt;foo&lt;<bar>',
  }

  examples.each do |input, expectation|
    context "with #{input.inspect} as input" do
      let(:input) { input }
      it { should eql(HTML::Fragment.new(expectation)) }
    end
  end
end
