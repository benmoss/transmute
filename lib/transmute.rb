require "transmute/version"
require "transmute/document"

module Transmute
  def self.html_resource(path)
    Document.from_path(path)
  end
end
