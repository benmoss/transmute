require 'nokogiri'

module Transmute
  class Node
    def self.from_path(path)
      new(Nokogiri::HTML(File.read(path)))
    end

    def initialize(nokogiri_node)
      self.nokogiri_node = nokogiri_node
    end

    def css(selector)
      nokogiri_node.css(selector).map {|n| self.class.new(n) }
    end

    def to_html
      nokogiri_node.to_html
    end

    def content=(content)
      case content
      when String
        nokogiri_node.content = content
      when Hash
        child = Nokogiri::XML::Node.new(content[:tag], nokogiri_node)
        self.class.new(child).content = content[:content]
        nokogiri_node.inner_html = child
      end
    end

    def dup
      dup = super
      dup.send(:nokogiri_node=, nokogiri_node.dup)
      dup
    end

    private
    attr_accessor :nokogiri_node
  end
end
