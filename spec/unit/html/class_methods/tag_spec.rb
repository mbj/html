# encoding: UTF-8

require 'spec_helper'

describe HTML, '.tag' do
  let(:object) { described_class }

  subject { object.tag(*arguments) }

  let(:name) { 'foo' }

  context 'without attributes' do
    let(:arguments) { [ name ] }

    it 'should return html fragment' do
      should eql(HTML::Fragment.new('<foo/>'))
    end
  end

  context 'with attributes' do
    let(:arguments) { [ name, attributes ] }

    context 'empty' do
      let(:attributes) { {} }

      it 'should return html fragment' do
        should eql(HTML::Fragment.new('<foo/>'))
      end
    end

    context 'non empty' do
      let(:attributes) { { :foo => :bar } }

      it 'should return html fragment' do
        should eql(HTML::Fragment.new('<foo foo="bar"/>'))
      end
    end
  end
end
