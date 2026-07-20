# The query classes keep `endpoint` and `client` private -- they are internals,
# not API. rspec-its 2.0 resolves the subject with public_send, so `its(:endpoint)`
# cannot reach them, and widening the API just to make a matcher work would be
# the tail wagging the dog.
#
# These shared examples reach them explicitly, so the explanation lives here
# once instead of on every spec that needs it.

RSpec.shared_examples "a query targeting" do |endpoint|
  it "targets #{endpoint}" do
    expect(query.send(:endpoint)).to eq(endpoint)
  end
end

RSpec.shared_examples "a query using client" do |description|
  it "uses #{description}" do
    expect(query.send(:client)).to eq(expected_client)
  end
end
