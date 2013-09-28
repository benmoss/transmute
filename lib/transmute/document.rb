require_relative 'node'

module Transmute
  class Document
    def self.from_path(path)
      new(Node.from_path(path))
    end

    def initialize(node, *transforms)
      self.node = node
      self.transforms = transforms
    end

    def to_html
      dup = node.dup
      transforms.each do |selector, transform|
        dup.css(selector).each(&transform)
      end
      dup.to_html
    end

    def transform(selector, &block)
      self.class.new(node, *transforms, [selector, block])
    end

    private
    attr_accessor :node, :transforms
  end
end
