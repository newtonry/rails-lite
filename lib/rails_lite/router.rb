class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern = pattern 
    @http_method = http_method 
    @controller_class = controller_class
    @action_name = action_name 
  end

  def matches?(req)
    return false if @pattern.matches(req.path).nil?
    return false if @http_method != req.request_method.downcase.to_sym
    true
  end

  def run(req, res)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes
  end

  def add_route(pattern, method, controller_class, action_name)
    @routes = Route.new(pattern, method, controller_class, action_name)
  end

  def draw(&proc)
  end

  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller_class, action_name|
      add_route(pattern, http_method, controller_class, action_name)
    end
    # add these helpers in a loop here
  end

  def match(req)
    @routes.each do |route|
      return route if route.matches?(req)
  end

  def run(req, res)
  end
end
