require 'nokogiri'

module Transmute
  class Document
    def self.from_path(path)
      new(Nokogiri::HTML(File.read(path)))
    end

    def initialize(node)
      self.node = node
    end

    def to_html
      node.to_html
    end

    def transform(selector)
      dup = node.dup
      dup.css(selector).each do |node|
        yield node
      end

      self.class.new(dup)
    end

    private
    attr_accessor :node
  end
end
