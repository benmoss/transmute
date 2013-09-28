require_relative "../lib/transmute"

include Transmute

describe Transmute do
  describe ".html_resource" do
    it "returns a document from a file path" do
      document = Transmute.html_resource("spec/fixtures/sample.html")
      document.should be_instance_of(Document)
    end
  end
end
