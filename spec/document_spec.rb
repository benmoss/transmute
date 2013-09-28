require_relative "../lib/transmute/document"

include Transmute

describe Document do
  describe "#transform" do
    it "applies a transformation to the subnodes that match the selector" do
      document = Document.from_path("spec/fixtures/sample.html")
      document.
        transform("body") { |node| node.content = "sup" }.
        to_html.should =~ /sup/
    end

    it "is immutable" do
      document = Document.from_path("spec/fixtures/sample.html")
      document.transform("body") { |node| node.content = "sup" }
      document.to_html.should =~ /original content/
    end

    it "is chainable" do
      document = Document.from_path("spec/fixtures/sample.html")
      document.
        transform("body") { |node| node.content = "sup" }.
        transform("body") { |node| node.content = "dude" }.
        to_html.should =~ /dude/
    end
  end
end
