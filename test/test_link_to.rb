require 'minitest/autorun'
require "shoulda/context"
require "js-rails-routes"
require "execjs"

class TestJsRailsRoutes < Minitest::Test
  context "When evaluating link_to" do
    should "make simple link with text and url" do
      text = ""
      routes = JsRailsRoutes::Routes.new(text).create_javascript
      js_script = ExecJS.compile(routes)
      
      result = js_script.call('link_to', "Home", "/")
      
      assert_equal '<a href="/">Home</a>', result
    end

    should "make link with an id" do
      text = ""
      routes = JsRailsRoutes::Routes.new(text).create_javascript
      js_script = ExecJS.compile(routes)
      
      result = js_script.call('link_to', "Home", "/", { id: 'my-link' })
      
      assert_equal '<a href="/" id="my-link">Home</a>', result
    end

    should "make link with a class" do
      text = ""
      routes = JsRailsRoutes::Routes.new(text).create_javascript
      js_script = ExecJS.compile(routes)
      
      result = js_script.call('link_to', "Home", "/", { class: 'my-link' })
      
      assert_equal '<a href="/" class="my-link">Home</a>', result
    end

    should "make link with both an id and a class" do
      text = ""
      routes = JsRailsRoutes::Routes.new(text).create_javascript
      js_script = ExecJS.compile(routes)
      
      result = js_script.call('link_to', "Home", "/", { id: 'my-id', class: 'my-class' })
      
      assert_equal '<a href="/" id="my-id" class="my-class">Home</a>', result
    end

    should "make link with a data method post" do
      text = ""
      routes = JsRailsRoutes::Routes.new(text).create_javascript
      js_script = ExecJS.compile(routes)
      
      result = js_script.call('link_to', "Home", "/", { method: 'post' })
      
      assert_equal '<a href="/" rel="nofollow" data-method="post">Home</a>', result
    end

    should "make link with a confirm message" do
      text = ""
      routes = JsRailsRoutes::Routes.new(text).create_javascript
      js_script = ExecJS.compile(routes)
      
      result = js_script.call('link_to', "Home", "/", { method: "delete", data: { confirm: "Are you sure?"} })
      
      assert_equal '<a href="/" rel="nofollow" data-method="delete" data-confirm="Are you sure?">Home</a>', result
    end

    should "not define link_to function when passed false" do
      text = ""
      routes = JsRailsRoutes::Routes.new(text).create_javascript(false)
      js_script = ExecJS.compile(routes)
      
      assert_raises ExecJS::ProgramError do
        result = js_script.call('link_to', "Home", "/", { method: 'post' })
      end
    end    
  end
end
