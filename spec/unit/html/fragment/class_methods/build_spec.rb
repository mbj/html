# encoding: UTF-8

require 'spec_helper'

describe HTML::Fragment, '.build' do
  let(:object) { described_class }
  subject { object.build(input) }

  context 'when input is string' do
    let(:input) { '<foo>' }

    it 'should store escaped string' do
      subject.content.should eql('&gt;foo&lt;')
    end

    it { should be_a(described_class) }
  end

  context 'when input is HTML::Fragment' do
    let(:input) { HTML::Fragment.new(double) }

    it 'should be input' do
      should be(input)
    end
  end
end
