Feature: Modify a template
  Scenario:
    Given a file named "sample.html" with:
      """
      <html><body></body></html>
      """
    And a file named "transmute.rb" with:
      """ruby
      require 'transmute'

      puts Transmute.html_resource("sample.html").
        transform("body") {|node| node.content = "this library looks interesting" }.
        to_html
      """
    When I run `ruby transmute.rb`
    Then the output should contain:
    """
    <html><body>this library looks interesting</body></html>
    """
