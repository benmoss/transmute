require 'nokogiri'

module Transmute
  class Node
    def self.from_path(path)
      new(Nokogiri::HTML(File.read(path)))
    end

    def initialize(nokogiri)
      @nokogiri = nokogiri
    end

    def css(selector, &block)
      @nokogiri.css(selector, &block)
    end

    def to_html
      @nokogiri.to_html
    end

    def dup
      duped = super
      duped.instance_variable_set("@nokogiri", @nokogiri.dup)
      duped
    end
  end
end
