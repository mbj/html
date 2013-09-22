require 'spec_helper'

describe HTML, '.tag' do
  let(:object) { described_class }

  subject { object.content_tag(*arguments) }

  let(:name)    { 'foo'     }
  let(:content) { 'content' }

  context 'without attributes' do
    let(:arguments) { [ name, content ] }

    it 'should return html fragment' do
      should eql(HTML::Fragment.new('<foo>content</foo>'))
    end
  end

  context 'with plaintext content' do
    let(:arguments) { [ name, content] }

    let(:content) { '<foo>' }

    it 'should return html fragment wrapping excapted content' do
      should eql(HTML::Fragment.new('<foo>&gt;foo&lt;</foo>'))
    end
  end

  context 'with attributes' do
    let(:arguments) { [ name, content, attributes ] }

    context 'empty' do
      let(:attributes) { {} }

      it 'should return html fragment' do
        should eql(HTML::Fragment.new('<foo>content</foo>'))
      end
    end

    context 'non empty' do
      let(:attributes) { { :foo => :bar } }

      it 'should return html fragment' do
        should eql(HTML::Fragment.new('<foo foo="bar">content</foo>'))
      end
    end
  end
end
