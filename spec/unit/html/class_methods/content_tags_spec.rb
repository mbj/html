# encoding: UTF-8

require 'spec_helper'

describe HTML, 'content tags' do
  let(:object) { described_class }

  HTML::CONTENT_TAGS.each do |name|
    it "should render #{name} correcty" do
      object.public_send(name, 'content', {:foo => :bar}).content.should eql(%Q(<#{name} foo="bar">content</#{name}>))
    end
  end
end
