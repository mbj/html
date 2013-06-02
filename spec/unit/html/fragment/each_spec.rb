require 'spec_helper'

describe HTML::Fragment, '#each' do
  let(:yields) { [] }

  let(:object) { described_class.new(chunk) }

  let(:chunk) { mock('Chunk') }

  subject { object.each { |chunk| yields << chunk } }

  it 'should enumerate chunks' do
    expect { subject }.to change { yields }.from([]).to([chunk])
  end
end
