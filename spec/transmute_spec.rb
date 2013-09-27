require_relative "../lib/transmute"

describe Transmute do
  describe ".html_resource" do
    it "returns a document from a file path" do
      document = Transmute.html_resource("spec/fixtures/sample.html")
      document.to_html.should == File.read("spec/fixtures/sample.html")
    end
  end
end
