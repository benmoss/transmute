require_relative "../lib/transmute/document"

include Transmute

describe Document do
  describe "#transform" do
    it "applies a transformation to the subnodes that match the selector" do
      document = Document.
        from_path("spec/fixtures/sample.html").
        transform("body") { |node| node.content = "sup" }

      expect(document.to_html).to match(/sup/)
    end

    it "returns a new document instead of modifying the original" do
      document = Document.from_path("spec/fixtures/sample.html")
      document.transform("body") { |node| node.content = "sup" }
      expect(document.to_html).to match(/original content/)
    end

    it "is chainable" do
      document = Document.
        from_path("spec/fixtures/sample.html").
        transform(".one") { |node| node.content = "sup" }.
        transform(".two") { |node| node.content = "dude" }
        expect(document.to_html).to match(/sup.*dude/m)
    end
  end

  describe "#to_html" do
    it "does not modify the underlying node" do
      node = Node.from_path("spec/fixtures/sample.html")
      document = Document.
        new(node).
        transform("body") { |node| node.content = "sup" }

      document.to_html.should_not == node.to_html
    end
  end
end
