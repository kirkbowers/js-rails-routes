require 'minitest/autorun'
require "shoulda/context"
require "js-rails-routes"
require "execjs"

class TestJsRailsRoutes < Minitest::Test
  context "When converting routes" do
    should "convert simple route with depth of one" do
      text = <<EOF
                       login GET    /login(.:format)                                                     login#login   
EOF
    
      routes = JsRailsRoutes::Routes.new(text).create_javascript
      js_script = ExecJS.compile(routes)
      
      result = js_script.call('login_path')
      
      assert_equal '/login', result
    end
  
    should "convert simple route with depth of two" do
      text = <<EOF
                    new_item GET    /items/new(.:format)                                             items#new
EOF
    
      routes = JsRailsRoutes::Routes.new(text).create_javascript
      js_script = ExecJS.compile(routes)
      
      result = js_script.call('new_item_path')
      
      assert_equal '/items/new', result
    end
  
    should "convert two simple routes" do
      text = <<EOF
                       login GET    /login(.:format)                                                     login#login   
                    new_item GET    /items/new(.:format)                                             items#new
EOF
    
      routes = JsRailsRoutes::Routes.new(text).create_javascript
      js_script = ExecJS.compile(routes)
      
      result = js_script.call('login_path')
      
      assert_equal '/login', result

      result = js_script.call('new_item_path')
      
      assert_equal '/items/new', result
    end
  
    should "ignore a route with no name" do
      text = <<EOF
                       login GET    /login(.:format)                                                     login#login   
                             GET    /login/new(.:format)                                             login#new
EOF
    
      routes = JsRailsRoutes::Routes.new(text).create_javascript
      js_script = ExecJS.compile(routes)
      
      result = js_script.call('login_path')
      
      assert_equal '/login', result
    end
  
    context 'with a path with one parameter' do
      setup do
        text = <<EOF
               edit_wishlist GET    /wishlists/:id/edit(.:format)                                        wishlists#edit
EOF
        routes = JsRailsRoutes::Routes.new(text).create_javascript
        @js_script = ExecJS.compile(routes)
      
      end
      
      should 'work with an integer argument' do
        result = @js_script.call('edit_wishlist_path', 1)
        assert_equal '/wishlists/1/edit', result
      end
    
      should 'work with an object argument' do
        result = @js_script.call('edit_wishlist_path', { id: 1 })
        assert_equal '/wishlists/1/edit', result
      end
    
    end


    context 'with a path with two parameters' do
      setup do
        text = <<EOF
               wishlist_item PATCH  /wishlists/:wishlist_id/items/:id(.:format)                          items#update
EOF
        routes = JsRailsRoutes::Routes.new(text).create_javascript
        @js_script = ExecJS.compile(routes)
      
      end
      
      should 'work with integer arguments' do
        result = @js_script.call('wishlist_item_path', 1, 2)
        assert_equal '/wishlists/1/items/2', result
      end
    
      should 'work with an object argument' do
        result = @js_script.call('wishlist_item_path', { id: 2, wishlist_id: 1 })
        assert_equal '/wishlists/1/items/2', result
      end
    
    end
  end
end