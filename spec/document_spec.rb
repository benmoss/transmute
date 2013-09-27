require_relative "../lib/transmute/document"

include Transmute

describe Document do
  describe "#transform" do
    it "applies a transformation to the subnodes that match the selector" do
      html = Nokogiri::HTML.parse(File.read("spec/fixtures/sample.html"))
      document = Document.new(html)
      document.transform("body") { |node| node.content = "sup" }.
        to_html.delete("\n").should =~ /sup/
    end

    it "is immutable" do
      html = Nokogiri::HTML.parse(File.read("spec/fixtures/sample.html"))
      document = Document.new(html)
      document.transform("body") { |node| node.content = "sup" }
      document.to_html.should =~ /hi/
    end
  end
end
