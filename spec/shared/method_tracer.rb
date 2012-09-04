shared_examples "a method tracer" do
  # requires lets:  wobbler, traced_method

  it "counts calls" do
    subject.trace!(traced_method)
    traced_method.should_receive(:called!).exactly(3).times
    3.times { wobbler.wobble }
    expect(wobbler.wobbles).to eq(3)
  end

  it "forwards blocks" do
    subject.trace!(traced_method)
    block_call_count = 0
    3.times do
      wobbler.wobble { block_call_count += 1 }
    end
    expect(block_call_count).to eq(3)
  end
end


shared_examples "a singleton method tracer" do
  include_context "wobblers"
  let(:traced_method) { SLG::Meta::TracedMethod.new(wobbler_class, :singleton, :wobble) }
  let(:wobbler) { wobbler_class }
  it_behaves_like "a method tracer"
end

shared_examples "an instance method tracer" do
  include_context "wobblers"
  let(:traced_method) { SLG::Meta::TracedMethod.new(wobbler_class, :instance,  :wobble) }
  let(:wobbler) { wobbler_instance }
  it_behaves_like "a method tracer"
end
