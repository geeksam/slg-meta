shared_context "wobblers" do
  let(:wobbler_class) { new_weeble_class }
  let(:wobbler_instance) { wobbler_class.new }
end



shared_examples "a wobbler" do
  # requires let:  wobbler
  after(:each) { wobbler.wobbles = 0 }

  it "keeps count of calls to #wobble" do
    expect(wobbler.wobbles).to eq(0)
    wobbler.wobble
    expect(wobbler.wobbles).to eq(1)
    wobbler.wobble
    expect(wobbler.wobbles).to eq(2)
  end

  it "lets you set the count of calls to #wobble" do
    wobbler.wobbles = 42
    expect(wobbler.wobbles).to eq(42)
  end

  it "takes a block argument to #wobble" do
    expect { wobbler.wobble { raise 'heck' } }.to raise_error
  end
end
