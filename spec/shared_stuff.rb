shared_context "weebles" do
  let(:traced_instance_method)  { SLG::Meta::TracedMethod.for('Weeble#wobble') }
  let(:traced_singleton_method) { SLG::Meta::TracedMethod.for('Weeble.wobble') }
  let(:weeble) { Weeble.new }

  after(:each) do
    Weeble.wobbles = 0
  end
end


shared_examples "a method tracer" do
  describe "instance method tracing" do
    let(:wobbler) { Weeble.new }

    it "counts calls to the method, handling block arguments with aplomb" do
      subject.trace!(traced_instance_method)
      traced_instance_method.should_receive(:called!).exactly(3).times
      3.times { wobbler.wobble }
      expect(wobbler.wobbles).to eq(3)
    end

    # # TODO: make .trace! idempotent; calling it a second time seems to freeze everything.
    # it "handles block arguments"
  end

  describe "singleton method tracing" do
    let(:wobbler) { Weeble }

    it "traces calls to a singleton method" do
      subject.trace!(traced_singleton_method)
      traced_singleton_method.should_receive(:called!).exactly(4).times
      4.times do
        wobbler.wobble
      end
      expect(wobbler.wobbles).to eq(4)
    end

    # # TODO: make .trace! idempotent; calling it a second time seems to freeze everything.
    # it "handles block arguments"
  end
end
