module FakePages
  class HtmlPageBuilder
    TEMPLATE_PATH = 'spec/fixtures/html_template.html.haml'
    def call
      '<p>Rendered page</p>'
    end
  end
end
