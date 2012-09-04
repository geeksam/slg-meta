shared_context "weebles" do
  let(:traced_instance_method)  { SLG::Meta::TracedMethod.new(weeble_class, :instance,  :wobble) }
  let(:traced_singleton_method) { SLG::Meta::TracedMethod.new(weeble_class, :singleton, :wobble) }
  let(:weeble_class) { new_weeble_class }
  let(:weeble) { weeble_class.new }
end


shared_examples "a weeble class" do
  before(:each) do
    weeble_class.wobbles = 0
  end

  it "has a count of wobbles" do
    expect(weeble_class.wobbles).to eq(0)
    weeble_class.wobble
    expect(weeble_class.wobbles).to eq(1)
    weeble_class.wobble
    expect(weeble_class.wobbles).to eq(2)
    weeble_class.wobbles = 0
    expect(weeble_class.wobbles).to eq(0)
  end

  # NB: these tests are finicky.
  # If they start failing intermittently, it's probably because
  # multiple things are poking around in the Weeble class.
  # Leave that class for an integration spec that needs a proper class name.
  it "takes an argument to the class method" do
    expect { weeble_class.wobble { raise 'heck' } }.to raise_error
  end

  it "takes an argument to the instance method" do
    expect { weeble_class.new.wobble { raise 'kceh' } }.to raise_error
  end
end


shared_examples "a method tracer" do
  describe "instance method tracing" do
    let(:wobbler) { weeble_class.new }

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
    let(:wobbler) { weeble_class }

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
