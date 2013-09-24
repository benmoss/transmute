Feature: Modify a template
  Scenario:
    Given a file named "sample.html" with:
      """
      <html>
      <body>
      hey
      </body>
      </html>
      """
    And a file named "transmute.rb" with:
      """ruby
      require 'transmute'

      html = Transmute.html_resource("sample.html").
        transform("body") {|node| node.content = "sup" }.
        to_s
      """
    When I run `ruby transmute.rb`
    Then the output should contain:
    """
    <html>
    <body>
    sup
    </body>
    </html>
    """
