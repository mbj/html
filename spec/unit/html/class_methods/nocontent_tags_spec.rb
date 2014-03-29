# encoding: UTF-8

require 'spec_helper'

describe HTML, 'nocontent tags' do
  let(:object) { described_class }

  HTML::NOCONTENT_TAGS.each do |name|
    it "should render #{name} correcty" do
      object.public_send(name, :foo => :bar).content.should eql(%Q(<#{name} foo="bar"/>))
    end
  end
end
