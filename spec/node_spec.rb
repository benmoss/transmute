require_relative '../lib/transmute/node'

include Transmute

describe Node do
  let(:nokogiri_doc) { Nokogiri::HTML::DocumentFragment.parse("<div></div>") }


  describe ".from_path" do
    it "returns a new Node from a file path string" do
      node = Node.from_path("spec/fixtures/sample.html")
      node.css(".one").first.content = {tag: "p", content: "hi"}
      node.to_html.should == Nokogiri::HTML(
        <<-HTML
<!DOCTYPE html>
<html>
  <body>
    <div class=\"one\"><p>hi</p></div>
    <div class=\"two\">more content</div>
  </body>
</html>
        HTML
      ).to_html
    end
  end

  describe "#css" do
    it "returns an array of subnodes" do
      node = Node.new(nokogiri_doc)
      node.css("div").map(&:class).should == [Node]
    end
  end

  describe "#content=" do
    let(:nokogiri_node) { nokogiri_doc.css("div").first }
    let(:node) { Node.new(nokogiri_node) }

    it "accepts strings for setting text content" do
      node.content = "hi"
      node.to_html.should == "<div>hi</div>"
    end

    it "accepts hashes for setting html content" do
      node.content = {tag: "p", content: "hi"}
      node.to_html.should == "<div><p>hi</p></div>"
    end

    it "accepts nested hashes too" do
      node.content = {tag: "p", content: {tag: "span", content: "hi"}}
      node.to_html.should == "<div><p><span>hi</span></p></div>"
    end
  end

  describe "#dup" do
    it "copies itself and its underlying nokogiri node" do
      node = Node.new(nokogiri_doc)
      dup = node.dup

      node.content = "hi"
      dup.to_html.should == "<div></div>"
      dup.should be_instance_of(Node)
    end
  end
end
