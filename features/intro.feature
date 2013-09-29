Feature: Modify a template
  Scenario:
    Given a file named "sample.html" with:
      """
      <html><body></body></html>
      """
    And a file named "transmute.rb" with:
      """ruby
      require 'transmute'

      document = Transmute.html_resource("sample.html").
        transform("body") do |node|
          node.content = {tag: "div", content:
            {tag: "p", content: "this library looks interesting"}
          }
        end
        puts document.to_html
      """
    When I run `ruby transmute.rb`
    Then the output should contain:
    """
    <html><body><div><p>this library looks interesting</p></div></body></html>
    """
